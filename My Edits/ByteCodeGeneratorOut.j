.class public ByteCodeGenerator
.super java/lang/Object
.method public <init>()V
aload_0
invokenonvirtual java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 100

fstore 13
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   13
invokevirtual java/io/PrintStream/println(F)V

iconst_4
imul
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V

iconst_1
imul
iconst_2
imul
iconst_2
imul
iconst_2
imul
iconst_2
imul
iconst_2
imul
iconst_2
imul
i2f
ldc	1.5
fmul
fstore 12
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   12
invokevirtual java/io/PrintStream/println(F)V

fstore 12
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   12
invokevirtual java/io/PrintStream/println(F)V

iconst_1
imul
i2f
ldc	1.5
ldc	3.0
fmul
fadd
ldc	1.0
ldc	1.0
fmul
fadd
ldc	3.0
ldc	3.5
fmul
fadd
ldc	3.0
ldc	3.5
fmul
fadd
fstore 13
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   13
invokevirtual java/io/PrintStream/println(F)V

fstore 13
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   13
invokevirtual java/io/PrintStream/println(F)V

iconst_1
imul
i2f
fload 13
fmul
ldc	1.0
ldc	1.0
fmul
ldc	1.0
fmul
ldc	1.0
fmul
ldc	1.0
fmul
fload 13
fmul
fadd
ldc	1.0
fload 13
fmul
fadd
fload 13
fadd
fstore 14
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   14
invokevirtual java/io/PrintStream/println(F)V

fstore 14
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   14
invokevirtual java/io/PrintStream/println(F)V

istore 4
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   4
invokevirtual java/io/PrintStream/println(I)V

iload 3
iload 4
if_icmplt     L2
goto L0


bipush    50
if_icmplt     L5
goto L4


iconst_1
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
goto L3


bipush    70
if_icmplt     L8
goto L7


iload 3
bipush    70
if_icmplt     L11
goto L9


iconst_2
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V

L9: 
goto L6


iconst_5
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
L6: 


L0: 

istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V

.end method