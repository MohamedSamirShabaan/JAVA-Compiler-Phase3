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
ldc	1.0
fstore 13
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   13
invokevirtual java/io/PrintStream/println(F)V
iconst_1
iconst_4
imul
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
iconst_1
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
fload 12
fstore 12
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   12
invokevirtual java/io/PrintStream/println(F)V
iconst_1
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
fload 13
fstore 13
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   13
invokevirtual java/io/PrintStream/println(F)V
iconst_1
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
fload 14
fstore 14
getstatic java/lang/System/out Ljava/io/PrintStream;
fload   14
invokevirtual java/io/PrintStream/println(F)V
bipush    100
istore 4
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   4
invokevirtual java/io/PrintStream/println(I)V
L1: 
iload 3
iload 4
if_icmplt     L2
goto L0
L2: 
iload 3
bipush    50
if_icmplt     L5
goto L4
L5: 
iload 3
iconst_1
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
goto L3
L4: 
iload 3
bipush    70
if_icmplt     L8
goto L7
L8: 
L10: 
iload 3
bipush    70
if_icmplt     L11
goto L9
L11: 
iload 3
iconst_2
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
goto L10
L9: 
goto L6
L7: 
iload 3
iconst_5
iadd
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
L6: 
L3: 
goto L1
L0: 
iload 3
istore 3
getstatic java/lang/System/out Ljava/io/PrintStream;
iload   3
invokevirtual java/io/PrintStream/println(I)V
return
.end method
