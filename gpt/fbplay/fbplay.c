#include <stdio.h>
#include <stdlib.h>
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/avutil.h"
#include "libavutil/mem.h"
#include "libavutil/fifo.h"
#include "libswscale/swscale.h"
#include<sys/time.h>
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <getopt.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <asm/types.h>
#include <linux/videodev2.h>
#include <linux/fb.h>

struct timeval timeStart,timeEnd;
double runTime=0;

struct buffer {
    void * start;
    size_t length;
};

static char * dev_name = NULL;
static int fd = -1;
struct buffer * buffers = NULL;
static unsigned int n_buffers = 0;

static int fbfd = -1;
static struct fb_var_screeninfo vinfo;
static struct fb_fix_screeninfo finfo;
static char *fbp=NULL;
static long screensize=0;

static int xioctl (int fd,int request,void * arg)
{
    int r;
    do r = ioctl (fd, request, arg);
    while (-1 == r && EINTR == errno);
    return r;
}

static void init_mmap (void)
{
    struct v4l2_requestbuffers req;

    //mmap framebuffer
    fbp = (char *)mmap(NULL,screensize,PROT_READ | PROT_WRITE,MAP_SHARED ,fbfd, 0);
    if(fbp == MAP_FAILED) {
        printf("Error: failed to map framebuffer device to memory./n");
        exit (EXIT_FAILURE) ;
    }

    memset(fbp, 0x0, screensize);
}

static void init_device (void)
{
    // Get fixed screen information
    if (-1==xioctl(fbfd, FBIOGET_FSCREENINFO, &finfo)) {
    printf("Error reading fixed information./n");
    exit (EXIT_FAILURE);
    }

    // Get variable screen information
    if (-1==xioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo)) {
    printf("Error reading variable information./n");
    exit (EXIT_FAILURE);
    }

    screensize = vinfo.xres * vinfo.yres * 2;
    init_mmap ();
}


static void open_device (void)
{
    struct stat st;
    unsigned char *fbase;
    struct fb_var_screeninfo vinfo;
    struct fb_fix_screeninfo finfo;
    	
    //open framebuffer
        fbfd = open("/dev/fb0", O_RDWR);
        if (fbfd==-1) {
            printf("Error: cannot open framebuffer device./n");
            exit (EXIT_FAILURE);
        }

    fbase = (void *)malloc(0x200000);
    if(fbase ==NULL){
    	printf("alloc space failed \n");
    }
}

int main(int argc, char *argv[])
{
    char input[256] = {0};
    int time_out=33;
    open_device();
    init_device();
    strcpy(input, argv[1]);
    av_register_all();
    AVFormatContext *pFormatCtx=avformat_alloc_context();

    if(avformat_open_input(&pFormatCtx,input,NULL,NULL)!=0)
    {
        printf("%s\n","no video\n");
        return -1;
    }

    if (avformat_find_stream_info(pFormatCtx,NULL)<0)
    {
       printf("%s\n","no video info\n");
       return -1;
    }

    av_dump_format(pFormatCtx,0,input,0);
    int v_stream_idx=-1;
    int i=0;
    for(;i<pFormatCtx->nb_streams;i++)
    {
        if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO)
        {
            v_stream_idx=i;
            break;
        } 
    }
    if(v_stream_idx==-1)
    {
        printf("%s\n","no video stram\n");
        return -1; 
    }

    AVCodecContext *pCodecCtx=pFormatCtx->streams[v_stream_idx]->codec;
    AVCodec *pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
    if(pCodec==NULL)
    {
        printf("%s\n","no decoder");
        return -1;
    }

    if (argc >=3) 
    {
        int  thread_count=atoi(argv[2]);
        pCodecCtx->thread_count = thread_count;
    }
    printf("NOW  threads is %d\n",pCodecCtx->thread_count);

    if (argc >=4) 
    {
        time_out=atoi(argv[3]);
    }
    printf("NOW  time_out is %d\n",time_out);
    
    if(avcodec_open2(pCodecCtx,pCodec,NULL)<0)
    {
        printf("%s\n","decoder can't open");
        return -1;
    }
    
    AVPacket *packet=(AVPacket*)av_malloc(sizeof(AVPacket));
    AVFrame *pFrame=av_frame_alloc();
    AVFrame *pFrameYUV=av_frame_alloc();
    uint8_t *out_buffer=(uint8_t*)av_malloc(avpicture_get_size(AV_PIX_FMT_UYVY422,(pCodecCtx->width),(pCodecCtx->height)));
    avpicture_fill((AVPicture*)pFrameYUV,out_buffer,AV_PIX_FMT_UYVY422,(pCodecCtx->width),(pCodecCtx->height));
    struct SwsContext *sws_ctx=sws_getContext(pCodecCtx->width,pCodecCtx->height,pCodecCtx->pix_fmt,(pCodecCtx->width),(pCodecCtx->height),AV_PIX_FMT_UYVY422,SWS_BICUBIC,NULL,NULL,NULL);
    int got_picture,ret;
    int frame_count=0;
    printf("start\n");
    gettimeofday(&timeStart,NULL);
    char buff[0x1c2000] = {0};
    while(av_read_frame(pFormatCtx,packet)>=0)
    {
        if(packet->stream_index==v_stream_idx)
        {   
            ret=avcodec_decode_video2(pCodecCtx,pFrame,&got_picture,packet);
            if(ret<0)
            {
                printf("%s\n","decode error");
                return -1;
            }
            if(got_picture)
            {
                sws_scale(sws_ctx,pFrame->data,pFrame->linesize,0,pCodecCtx->height,pFrameYUV->data,(pFrameYUV->linesize));
                while(runTime<=time_out)    
                {                      
                    gettimeofday(&timeEnd,NULL);
                    runTime=(timeEnd.tv_sec-timeStart.tv_sec)*1000+(double)(timeEnd.tv_usec-timeStart.tv_usec)/1000;
                }
                timeStart.tv_sec=timeEnd.tv_sec;
                timeStart.tv_usec=timeEnd.tv_usec;
                runTime=0;
                memcpy(fbp, pFrameYUV->data[0], (pCodecCtx->width)*(pCodecCtx->height)*2);
            }        
        }
        av_free_packet(packet);
    }

    while(1)
    {
        ret=avcodec_decode_video2(pCodecCtx,pFrame,&got_picture,packet);
        if(ret<0)
        {
            break;
        }
        if(!got_picture)
        {
            break;
        }
        sws_scale(sws_ctx,pFrame->data,pFrame->linesize,0,pCodecCtx->height,pFrameYUV->data,pFrameYUV->linesize);
        while(runTime<=time_out)    
        {                      
            gettimeofday(&timeEnd,NULL);
            runTime=(timeEnd.tv_sec-timeStart.tv_sec)*1000+(double)(timeEnd.tv_usec-timeStart.tv_usec)/1000;
        }
        timeStart.tv_sec=timeEnd.tv_sec;
        timeStart.tv_usec=timeEnd.tv_usec;
        runTime=0;
        memcpy(fbp, pFrameYUV->data[0], (pCodecCtx->width)*(pCodecCtx->height)*2);
    }
    sws_freeContext(sws_ctx);
    av_frame_free(&pFrame);
    avcodec_close(pCodecCtx);
    avformat_free_context(pFormatCtx);

    printf("video end!\n");

    return 0;
}
