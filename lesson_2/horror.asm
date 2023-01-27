
data1 segment
  x db "XXXXX"
  y dw "YYYYY"
data1 ends
 
data2 segment
  z dw "ZZZZZ"
  w dw "WWWWW"
data2 ends
 

assume ds:data1
  lea si, [x]     ; move offset of x segment for SI (Source Index)
  push es
  mov ax, data2
  mov es, ax
assume es:data2
  lea di, es:[z]
  pop es
assume es:nothing




