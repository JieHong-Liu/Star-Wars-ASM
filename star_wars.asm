printStr  macro string
      lea dx,string 
      mov ah,09h
      int 21h
      endm
printtt macro char1
      mov dl,char1
      mov ah,02h
      int 21h
endm
setting macro  x
      mov ah,02h 
      mov bh,0
      mov dh,0
      mov dl,x
      int 10h
endm
Getchar  macro 
        mov ah,06h
        mov dl,0ffh
 int 21h
endm
Getchar1  macro 
   mov ah,07h
   int 21h
   endm
SetMode  macro mode
   mov ah,00h
   mov al,mode
   int 10h
   endm

SetColor macro mode,color
   mov ah,0bh
   mov bh,mode
   mov bl,color
   int 10h
   endm
WrPixel  macro x,y,color
   mov ah,0ch
   mov bh,00h
   mov al,color
   mov cx,x
   mov dx,y
   int 10h
   endm
 read_color macro x,y,color
   mov al,0000b
   mov ah,0dh
   mov bh,00h
   mov cx,x
   mov dx,y 
   int 10h 
endm
.8086
.model small
.stack 1024

.data

logo1 db 10,13,10,13,10,13,10,13,10,13, 
    "       * * * * *      * * * * *        *          * * * *       ",10,13,
    "       *                  *          *   *        *       *     ",10,13,
    "       * * * * *          *         *     *       * * * * *     ",10,13,
    "               *          *        * * * * *      *       *     ",10,13,
    "       * * * * *          *       *         *     *       *     ",10,13,'$' 
    
logo2 db  10,13,
    "                                                                 ",10,13,
    "    *       *       *              *                * * * *      ",10,13,     
    "     *     * *     *             *   *              *       *    ",10,13,
    "      *   *   *   *             *     *             * * * * *    ",10,13, 
    "       * *     * *             * * * * *            *       *    ",10,13,
    "        *       *             *         *           *       *    ",10,13,'$'
str1  db  10,13,10,13,10,13,
    "                 The goal is to dodge the meteor                 ",10,13,
    "         you can press W to go up and press S to go down         ",10,13,10,13,10,13,
    "               please press space to start the game              ",10,13,'$'
godown  db 10,13,"         * * * * * * *                  *           ",10,13,
                 "               *                    * * * * *       ",10,13,
                 "               *                        *           ",10,13,'$'
godown1 db       "               * *                * * * * * * *     ",10,13,
                 "               *   *                    *           ",10,13,
                 "               *     *                *     *       ",10,13,
                 "               *                    * * * * * *     ",10,13,
                 "               *                                *   ",'$'

you     db  10,13,  
            "       *       *           * * * * *           *       *        ",10,13,
            "        *     *            *       *           *       *        ",10,13,
            "         *   *             *       *           *       *        ",10,13,'$'
you2 db     "           *               *       *           *       *        ",10,13,
            "           *               *       *           *       *        ",10,13,
            "           *               * * * * *           * * * * *        ",10,13,'$'
win    db   "        *       *       *     * * * * *         *       *       ",10,13,
            "         *     * *     *          *             * *     *       ",10,13,
            "          *   *   *   *           *             *   *   *       ",10,13,'$'
win2   db   "           * *     * *            *             *     * *       ",10,13,
            "            *       *         * * * * *         *       *       ",10,13,'$' 
winstr   db 10,13,
            "Congratulation you arrive the planet 100 light year away!" ,10,13,'$'

pntleave  db  10,13,"press esc to leave the game!",10,13,'$'
change_line db 10,13,'$' 
pnt_score db  "your score:",'$'
pnt_over  db  10,13,"Game over !!! and your score is : ",'$'
pnt_again db  10,13,"If tou want to play again, press enter",'$'
score      db "0",10,13,10,13,'$' 

returngame db 10,13,10,13,"press R to return your game. ",'$' 
return  db 10,13,"          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,'$'
return1 db       "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,
                 "          * * *                      * * *          ",10,13,'$'
starYnum dw 475
starXnum dw 635
dxvalue dw 200 ;adjust position
divalue dw 20  ;di=cx
cxvalue dw 20 ;di=cx
sivalue dw 220 ;adjust scale
lengthh  dw 1  ;adjust upper length
odxvalue dw 0 ;store data
odivalue dw 0  
ocxvalue dw 0
osivalue dw 0
color   db 0110b
direction dw 0
coin_x  dw 615   ;
coin_y  dw 0   ;random
coin_y_bound dw 0
coin_color db 1110b
random_y dw 0
running dw 0  ;1=running ,0=no running
cx_bound dw 25

stone_x  dw 615   ;
stone_y  dw 0   ;random
stonecxbound dw 25
stone_y_bound dw 0
keep_y_stonebound dw 0
colorforstone db 0111b

stone_x1  dw 615   ;
stone_y1  dw 0   ;random
stonecxbound1 dw 25
stone_y_bound1 dw 0
keep_y_stonebound1 dw 0
colorforstone1 db 0111b

stone_x2  dw 615   ;
stone_y2  dw 0   ;random
stonecxbound2 dw 25
stone_y_bound2 dw 0
keep_y_stonebound2 dw 0
colorforstone2 db 0111b

count dw 0  
speed dw 10
StoneOrCoin dw  0
seven  dw 7
num_440 dw 440
keep_y_bound dw 0

one db "1","0",'$'


.code
.startup

  printStr  logo1;印遊戲開場畫面
  printStr  logo2
  printStr  str1
not20h:
  getchar ;進入遊戲的判斷
  cmp al,20h
  je  Game
  jmp not20h 
Game:;進入繪圖模式
  SetMode 12h
  SetColor 00h,0000b

call pnt_Star ;印星星
printStr pnt_score;印分數
printStr score
mov cx,cxvalue  ;create airplane 
mov dx,dxvalue
mov di,divalue
mov si,sivalue
begin: 
call airplane;印飛機

moving:           ;移動飛機和讓石頭以及硬幣移動

mov ax,0
getchar
cmp al,77h
je up
cmp al,73h
je down
cmp al,1bh
je  done
cmp al,'p'
je  p
in  ax,40h
mov dx,0
jmp call_coin

up:                ;操控飛機向上移動
cmp odxvalue,20  ;4 ;讓飛機在螢幕範圍內，且不要清除到分數
jbe nomoving
call clearplane
sub odxvalue,6   ;4    ;一次移6pixel
mov dx,odxvalue
sub osivalue,6   ;4
jmp store           ;將一些值保存起來

down:             ;操控飛機向下移動
cmp odxvalue,440 ;432  ;讓飛機在螢幕範圍內
jae nomoving
call clearplane    
add odxvalue,6       ;一次移6pixel
mov dx,odxvalue
add osivalue,6
jmp store      ;將一些值保存起來

notmov1:          ;當吃到硬幣時，為了避免撞到硬幣飛機本體被消除，而讓飛機再印一次
call clearplane
mov dx,odxvalue
mov color,0110b
mov si,osivalue
mov di,odivalue 
mov cx,ocxvalue 
call airplane
jmp going1

notmov2:        ;當吃到硬幣時，為了避免撞到硬幣飛機本體被消除，而讓飛機再印一次
call clearplane
mov dx,odxvalue
mov color,0110b
mov si,osivalue
mov di,odivalue 
mov cx,ocxvalue 
call airplane
jmp going2

call_stone:         ;呼叫石頭
cmp stone_x,615      ;當石頭剛生成時，須將一些初始值定義好
jb stoneunfinished
  in  ax,40h         ;取亂數讓石頭可以在不同的y軸出現 
  mov dx,0            ;避免溢位
  div num_440       ;讓石頭可以在y軸0~439之間
  add dx,15          ;因為石頭大小為25*25，而最上面需顯示分數，避免石頭撞到分數，導致消除
  mov stone_y,dx       ;將石頭最左上角的值給stone_y
  mov stone_y_bound,dx  ;石頭y軸的邊界
  add stone_y_bound,25   ;因為是25*25，所以加上25
  mov keep_y_stonebound,dx  ;當石頭印完一次後，需做清除所以先把邊界值把持住

stoneunfinished:       ;當石頭不在剛生成狀態下時，就會先跑到這行
  call pnt_stone       ;印出石頭
call hit               ;判斷飛機是否有撞到石頭
 cmp al,0111b          ;當判斷飛機的顏色因被石頭灰色印上去，即表示石頭撞上飛機
 je dead               ;飛機死亡
  call mov_stone       ;會先做清除，再印一次石頭，達成石頭移動的效果的
call hit               ;判斷飛機是否有撞到石頭
 cmp al,0111b          ;當判斷飛機的顏色因被石頭灰色印上去，即表示石頭撞上飛機
 je dead               ;飛機死亡
  jmp call_stone1      ;這個石頭做完，跳下一個石頭做一樣的事


call_stone1:          ;與call_stone功能相同
cmp stone_x1,615
jb stone1unfinished
  in  ax,40h
  mov dx,0
  div num_440
  add dx,15
  mov stone_y1,dx
  mov stone_y_bound1,dx
  add stone_y_bound1,25
  mov keep_y_stonebound1,dx

stone1unfinished:
  call pnt_stone1
call hit
 cmp al,0111b
 je dead 
  call mov_stone1
call hit
 cmp al,0111b
 je dead 
  jmp call_stone2

call_stone2:                ;與call_stone功能相同
cmp stone_x2,615
jb stone2unfinished
  in  ax,40h
  mov dx,0
  div num_440
  add dx,15
  mov stone_y2,dx
  mov stone_y_bound2,dx
  add stone_y_bound2,25
  mov keep_y_stonebound2,dx

stone2unfinished:
  call pnt_stone2
call hit
 cmp al,0111b
 je dead 
  call mov_stone2
call hit
 cmp al,0111b
 je dead 
   jmp moving 




call_coin:           ;與call_stone功能大致相同

cmp coin_x,615         
jb unfinished

  in ax,40h
  mov dx,0
  div num_440
  add dx,15
  mov coin_y,dx
  mov coin_y_bound,dx
  add coin_y_bound,25
  mov keep_y_bound,dx

 
unfinished:
  call generate_coin
call hit
 cmp al,1110b
 je get_score1          ;當撞上硬幣加分
gogo1:                   ;這裡就是避免飛機撞上硬幣導致清除
  call mov_coin     
call hit
 cmp al,1110b
 je get_score2             ;當撞上硬幣加分
  jmp call_stone           ;跳至石頭，所以順序是先硬幣->石頭->石頭1->石頭2->石頭3
 
get_score1:            ;第一次加分
  call mov_coin        ;硬幣清除，再印一次硬幣
  add score,1           ;分數加一，score初始值為30h(ASCII 字元為0)
  jmp notmov1          ;加分完避免撞上硬幣導致清除，跳到notmov1
  going1:             
  cmp score,3ah      ;比較是否拿到十分了，若是跳至獲勝畫面
  je  winYA
  setting 11         ;將游標移置y軸為0，x軸為11的地方，這是讓新分數可以覆蓋掉舊分數
  printstr score     ;印分數
  mov coin_x,615     ;已撞上硬幣了，讓硬幣變為初始值，再從來印一次
  dec speed          ;延遲降低，也就是石頭以及硬幣速度變快
  jmp call_stone       ;跳至call_stone
get_score2:           ;第二次加分，設置這個是避免偵測到的是第二次的顏色
  add score,1         ;分數加一，score初始值為30h(ASCII 字元為0)
  jmp notmov2         ;加分完避免撞上硬幣導致清除，跳到notmov2
  going2:
  cmp score,3ah        ;比較是否拿到十分了，若是跳至獲勝畫面
  je  winYA        
  setting 11             ;將游標移置y軸為0，x軸為11的地方，這是讓新分數可以覆蓋掉舊分數
  printstr score              ;印分數
  mov coin_x,615            ;已撞上硬幣了，讓硬幣變為初始值，再從來印一次
  dec speed                 ;延遲降低，也就是石頭以及硬幣速度變快
  jmp call_stone              ;跳至call_stone
nomoving:               ;因飛機已經到邊界了
  call clearplane        ;清除飛機
  mov dx,odxvalue      ;原先值都不動
  jmp store          ;跳至儲存

store:           ;儲存
mov color,0110b    ;將舊的值都保存下來
mov si,osivalue
mov di,odivalue 
mov cx,ocxvalue 
jmp begin          ;跳至begin印飛機


clearpause:       ;暫停完要返回遊戲
call clear_star   ;把星星清掉
call pnt_Star     ;再把星星印回來
setting 0         ;設定游標位置，y軸為０，x軸為任意值
printstr pnt_score
printstr score
jmp nomoving

p:           
printStr  return  ;
printStr  return1 ;印return的圖
printStr  returngame;
again:
Getchar1  ;按下r可返回遊戲，按下esc可以離開遊戲
cmp al,'r'
je clearpause
cmp al,1bh
je done
jmp again
dead:
printStr godown;印出"下去"
printStr godown1
printstr pnt_over
printstr score;印出分數
printstr pnt_again
again1:
getchar1;判斷如果是esc就離開遊戲，如果是enter就重玩
cmp al,1bh
je done
cmp al,13 
je cccc
jmp again1
cccc:;設定重玩的參數
mov dxvalue,200 
mov divalue,20  
mov cxvalue,20 
mov sivalue,220 
mov coin_x,615
mov stone_x,615
mov stone_x1,615
mov stone_x2,615
mov score,30h
mov speed,10 
jmp Game

winya:;贏了
setting 0;設定滑鼠游標
printstr pnt_score;把分數，youwin等等給印出來
printstr one;
printStr you
printstr you2
printStr win
printStr win2
printStr winstr
printstr pntleave
again2:
getchar1
cmp al,1bh
je done
jmp again2
done:

  SetMode 03h;結束遊戲

.exit

pnt_Star proc  near;印星星的副程式

mov count,0;用一個count來計算到第幾個
pnt:
inc count;目標是印出如下的星星，首先印第一顆時count+1
        ;  *
        ; ***
        ;  *
in  ax,40h
mov dx,0
div starXnum
mov cx,dx


in  ax,40h
mov dx,0
div starYnum
mov dx,dx

WrPixel cx,dx,0Fh
inc dx
sub cx,2
mov bx,3
midiumline:
inc cx
dec bx
WrPixel cx,dx,0Fh
cmp bx,0
ja  midiumline
lastline:
inc dx
sub cx,1
WrPixel cx,dx,0Fh

mov bx,300
cmp count,bx
jb  pnt

ret
pnt_Star endp

clear_star proc near
mov cx,0
mov dx,0
Loop1:
WrPixel cx,dx,00h
inc cx 
cmp cx,639
jae chgline
jmp Loop1
chgline:
mov cx,0
inc dx
cmp dx,479
jae bye 
jmp Loop1
bye:
ret
clear_star endp

airplane proc near        ;印飛機

mov ocxvalue,cx  ;store old airplane  
mov odxvalue,dx
mov odivalue,di
mov osivalue,si
mov cxvalue,cx  ;create airplane 
mov dxvalue,dx
mov divalue,di
mov sivalue,si

work:                
mov cx,cxvalue
add di,lengthh      
add dx,1
cmp dx,si
je two

x_axis: 

add cx,1
Wrpixel cx,dx,color
cmp cx,di
jb x_axis
jmp work

two:
mov ax,sivalue
sub ax,dxvalue
add dxvalue,ax
add sivalue,ax
mov cx,cxvalue 
mov dx,dxvalue
add divalue,ax 
mov di,divalue
mov si,sivalue

work1:                
mov cx,cxvalue
dec di     
add dx,1
cmp dx,si
je judge

x_axis1: 

add cx,1
Wrpixel cx,dx,color
cmp cx,di
jb x_axis1
jmp work1

judge:

ret
airplane endp

clearplane proc near   ;clear_triangle

mov cx,ocxvalue        ;clear airplane 
mov dx,odxvalue 
mov di,odivalue
mov si,osivalue
mov cxvalue,cx  
mov dxvalue,dx
mov divalue,di
mov sivalue,si
mov color,0000b

work2:                
mov cx,cxvalue
add di,lengthh      
add dx,1
cmp dx,si
je two2

x_axis2: 

add cx,1
Wrpixel cx,dx,color
cmp cx,di
jb x_axis2
jmp work2

two2:
mov ax,sivalue
sub ax,dxvalue
add dxvalue,ax
add sivalue,ax
mov cx,cxvalue 
mov dx,dxvalue
add divalue,ax 
mov di,divalue
mov si,sivalue

work3:                
mov cx,cxvalue
dec di     
add dx,1
cmp dx,si
je judge1

x_axis3: 

add cx,1
Wrpixel cx,dx,color
cmp cx,di
jb x_axis3
jmp work3

judge1:

ret
clearplane endp

generate_coin proc near
  mov cx,coin_x
  mov dx,coin_y
  add cx_bound,cx
  re_x:
  wrpixel cx,dx,coin_color;
  inc cx;
  cmp cx,cx_bound;
   jae y_plus 
   jmp re_x
   y_plus:
   inc dx
   mov cx,coin_x;
   cmp dx,coin_y_bound              
   jb re_x
mov coin_x,cx 
mov bx,keep_y_bound 
mov coin_y,bx
mov cx_bound,25
   
ret
generate_coin endp
  
mov_coin  proc near
mov coin_color,0000b
call generate_coin
call Delay
cmp coin_x,7
jbe coin_disappear  ;
sub coin_x,7  ;4
mov coin_color,1110b
jmp tail
coin_disappear:  

mov coin_x,615
mov coin_color,1110b
tail:
ret

mov_coin endp

Delay proc  ;避免隕石或是錢幣消失太快，因此需要delay
  mov  cx,speed
 L1:
  push cx
  mov cx,65535
 L2:
  loop L2
  pop cx
  loop L1
  ret
Delay endp

pnt_stone proc near ;如coin，只是改名字跟顏色  
  mov cx,stone_x
  mov dx,stone_y
  add stonecxbound,cx

  re_x0:
  wrpixel cx,dx,colorforstone;
  inc cx;
  cmp cx,stonecxbound
   jae y_plus0 
   jmp re_x0
   y_plus0:
   inc dx
   mov cx,stone_x;
   cmp dx,stone_y_bound              
   jb re_x0
mov stone_x,cx  ;
mov bx,keep_y_stonebound
mov stone_y,bx 
mov stonecxbound,25
     
ret
pnt_stone endp
mov_stone  proc near;同mov_coin
mov colorforstone,0000b
call pnt_stone
call Delay
 cmp stone_x,8
 jbe stone_disappear  ;
sub stone_x,8
mov colorforstone,0111b
jmp weiba

stone_disappear:  
mov stone_x,615
mov colorforstone,0111b 
weiba:
ret
mov_stone endp

pnt_stone1 proc near  ;同 generate_coin，名字及參數及顏色改變
  mov cx,stone_x1
  mov dx,stone_y1
  add stonecxbound1,cx

  re_x1:
  wrpixel cx,dx,colorforstone1;
  inc cx;
  cmp cx,stonecxbound1
   jae y_plus1 
   jmp re_x1
   y_plus1:
   inc dx
   mov cx,stone_x1;
   cmp dx,stone_y_bound1              
   jb re_x1
mov stone_x1,cx  ;
mov bx,keep_y_stonebound1
mov stone_y1,bx 
mov stonecxbound1,25
     
ret
pnt_stone1 endp
  
mov_stone1  proc near ;同mov_stone
mov colorforstone1,0000b
call pnt_stone1
call Delay
 cmp stone_x1,7
 jbe stone1_disappear  ;
sub stone_x1,7
mov colorforstone1,0111b
jmp weiba1

stone1_disappear:  
mov stone_x1,615
mov colorforstone1,0111b 
weiba1:
ret
mov_stone1 endp

pnt_stone2 proc near   ;同 generate_coin，名字及參數及顏色改變
  mov cx,stone_x2
  mov dx,stone_y2
  add stonecxbound2,cx

  re_x2:
  wrpixel cx,dx,colorforstone2;
  inc cx;
  cmp cx,stonecxbound2
   jae y_plus2 
   jmp re_x2
   y_plus2:
   inc dx
   mov cx,stone_x2;
   cmp dx,stone_y_bound2              
   jb re_x2
mov stone_x2,cx  ;
mov bx,keep_y_stonebound2
mov stone_y2,bx 
mov stonecxbound2,25
     
ret
pnt_stone2 endp
mov_stone2  proc near;同mov_stone
mov colorforstone2,0000b
call pnt_stone2
call Delay
 cmp stone_x2,9
 jbe stone2_disappear  ;
sub stone_x2,9
mov colorforstone2,0111b
jmp weiba2

stone2_disappear:  
mov stone_x2,615
mov colorforstone2,0111b 
weiba2:
ret
mov_stone2 endp





hit proc near   ;judge_airplane_crach

mov cx,ocxvalue  ;store old airplane 
mov dx,odxvalue   ;
mov di,odivalue    ;
mov si,osivalue    ;
mov cxvalue,cx  ;create airplane 
mov dxvalue,dx
mov divalue,di
mov sivalue,si

wor:           ; 設定參數   
mov cx,cxvalue
add di,lengthh      
add dx,1
cmp dx,si
je three

x_axis18: ;

add cx,1
read_color cx,dx,color
cmp al,0110b
jne gotcha
cmp cx,di
jb x_axis18
jmp wor

three:;設定遊戲參數
mov ax,sivalue
sub ax,dxvalue
add dxvalue,ax
add sivalue,ax
mov cx,cxvalue 
mov dx,dxvalue
add divalue,ax 
mov di,divalue
mov si,sivalue

wor1:         ;設定參數
mov cx,cxvalue
dec di     
add dx,1
cmp dx,si
je judge87

x_axis87: 

add cx,1
read_color cx,dx,color;判斷飛機是不是棕色來決定有沒有死
cmp al,0110b
jne gotcha
cmp cx,di
jb x_axis87
jmp wor1

gotcha:

judge87:

ret
hit endp;結束

end
