PROGRAM 	= fbplay
CFLAGS 		= $(TARGET_DIR)/usr/include 
LDFLAGS 	= $(TARGET_DIR)/usr/lib 
LIBS 		= -lavutil -lavformat -lavcodec -lavutil -lswscale -lswresample \
			-lssl -lcrypto -lx264 -lm -ldl -lz -pthread -pthread -latomic

SOURCES 	= $(wildcard *.c)
OBJS 		= $(patsubst %.c,%.o,$(SOURCES))

$(PROGRAM) : $(OBJS)
	$(CC) $^ $(CFLAGS) $(LIBS) $(LDFLAGS) -o $(PROGRAM)

%.o : %.c
	$(CC) $(CFLAGS) $(LIBS) $(LDFLAGS) -c $< -o $@

.PHONY : clean
clean:
	rm -f *.o $(PROGRAM)
