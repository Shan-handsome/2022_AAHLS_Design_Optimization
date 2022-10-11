; ModuleID = 'D:/Courses/AAHLS_lab/labA/ug871-design-files/Design_Optimization/lab2/matrixmul_prj/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblememonly nounwind
declare void @llvm.sideeffect() #0

; Function Attrs: inaccessiblemem_or_argmemonly noinline
define void @apatb_matrixmul_ir([3 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="3" %a, [3 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="3" %b, [3 x i16]* noalias nocapture nonnull "fpga.decayed.dim.hint"="3" %res) local_unnamed_addr #1 {
entry:
  %a_copy1 = alloca [3 x i24], align 512
  %b_copy2 = alloca [3 x i24], align 512
  %res_copy = alloca [3 x [3 x i16]], align 512
  %0 = bitcast [3 x i8]* %a to [3 x [3 x i8]]*
  %1 = bitcast [3 x i8]* %b to [3 x [3 x i8]]*
  %2 = bitcast [3 x i16]* %res to [3 x [3 x i16]]*
  call void @copy_in([3 x [3 x i8]]* nonnull %0, [3 x i24]* nonnull align 512 %a_copy1, [3 x [3 x i8]]* nonnull %1, [3 x i24]* nonnull align 512 %b_copy2, [3 x [3 x i16]]* nonnull %2, [3 x [3 x i16]]* nonnull align 512 %res_copy)
  %a_copy.gep3 = getelementptr [3 x i24], [3 x i24]* %a_copy1, i64 0, i32 0
  %3 = getelementptr inbounds [3 x [3 x i16]], [3 x [3 x i16]]* %res_copy, i32 0, i32 0
  call void @llvm.sideeffect() #0 [ "xlx_array_reshape"(i24* %a_copy.gep3, i32 0, i32 1, i32 0) ], !dbg !5
  call void @llvm.sideeffect() #0 [ "xlx_array_reshape"([3 x i24]* %b_copy2, i32 0, i32 1, i32 0) ], !dbg !372
  call void @apatb_matrixmul_hw([3 x i24]* %a_copy1, [3 x i24]* %b_copy2, [3 x i16]* %3)
  call void @copy_back([3 x [3 x i8]]* %0, [3 x i24]* %a_copy1, [3 x [3 x i8]]* %1, [3 x i24]* %b_copy2, [3 x [3 x i16]]* %2, [3 x [3 x i16]]* %res_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0a3a3i16([3 x [3 x i16]]* noalias align 512, [3 x [3 x i16]]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [3 x [3 x i16]]* %0, null
  %3 = icmp eq [3 x [3 x i16]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %dst.addr57 = getelementptr [3 x [3 x i16]], [3 x [3 x i16]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %src.addr68 = getelementptr [3 x [3 x i16]], [3 x [3 x i16]]* %1, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %5 = load i16, i16* %src.addr68, align 2
  store i16 %5, i16* %dst.addr57, align 2
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.3.4([3 x i24]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0", [3 x [3 x i8]]* noalias readonly "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1") #2 {
entry:
  %2 = icmp eq [3 x i24]* %0, null
  %3 = icmp eq [3 x [3 x i8]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  %dst.addr571 = getelementptr [3 x i24], [3 x i24]* %0, i64 0, i64 %for.loop.idx10
  %dst.addr571.promoted = load i24, i24* %dst.addr571, align 4
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %5 = phi i24 [ %dst.addr571.promoted, %for.loop ], [ %14, %for.loop2 ]
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %6 = mul nuw nsw i64 8, %for.loop.idx39
  %src.addr68 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %1, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %7 = load i8, i8* %src.addr68, align 1
  %8 = trunc i64 %6 to i24
  %9 = shl i24 255, %8
  %10 = zext i8 %7 to i24
  %11 = shl i24 %10, %8
  %12 = xor i24 %9, -1
  %13 = and i24 %5, %12
  %14 = or i24 %13, %11
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  store i24 %14, i24* %dst.addr571, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.5.6([3 x i24]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0", [3 x [3 x i8]]* noalias readonly "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1") #2 {
entry:
  %2 = icmp eq [3 x i24]* %0, null
  %3 = icmp eq [3 x [3 x i8]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  %5 = mul nuw nsw i64 8, %for.loop.idx10
  %6 = trunc i64 %5 to i24
  %7 = shl i24 255, %6
  %8 = xor i24 %7, -1
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %dst.addr571 = getelementptr [3 x i24], [3 x i24]* %0, i64 0, i64 %for.loop.idx39
  %src.addr68 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %1, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %9 = load i8, i8* %src.addr68, align 1
  %10 = load i24, i24* %dst.addr571, align 4
  %11 = zext i8 %9 to i24
  %12 = shl i24 %11, %6
  %13 = and i24 %10, %8
  %14 = or i24 %13, %12
  store i24 %14, i24* %dst.addr571, align 4
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_in([3 x [3 x i8]]* noalias readonly "orig.arg.no"="0", [3 x i24]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1", [3 x [3 x i8]]* noalias readonly "orig.arg.no"="2", [3 x i24]* noalias align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3", [3 x [3 x i16]]* noalias readonly "orig.arg.no"="4", [3 x [3 x i16]]* noalias align 512 "orig.arg.no"="5") #3 {
entry:
  call void @onebyonecpy_hls.p0a3a3i8.3.4([3 x i24]* align 512 %1, [3 x [3 x i8]]* %0)
  call void @onebyonecpy_hls.p0a3a3i8.5.6([3 x i24]* align 512 %3, [3 x [3 x i8]]* %2)
  call fastcc void @onebyonecpy_hls.p0a3a3i16([3 x [3 x i16]]* align 512 %5, [3 x [3 x i16]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.11.12([3 x [3 x i8]]* noalias "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1") #2 {
entry:
  %2 = icmp eq [3 x [3 x i8]]* %0, null
  %3 = icmp eq [3 x i24]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  %src.addr681 = getelementptr [3 x i24], [3 x i24]* %1, i64 0, i64 %for.loop.idx10
  %5 = load i24, i24* %src.addr681, align 4
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %dst.addr57 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %6 = mul nuw nsw i64 8, %for.loop.idx39
  %7 = trunc i64 %6 to i24
  %8 = lshr i24 %5, %7
  %9 = trunc i24 %8 to i8
  store i8 %9, i8* %dst.addr57, align 1
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @onebyonecpy_hls.p0a3a3i8.13.14([3 x [3 x i8]]* noalias "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="0", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1") #2 {
entry:
  %2 = icmp eq [3 x [3 x i8]]* %0, null
  %3 = icmp eq [3 x i24]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx10 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  %5 = mul nuw nsw i64 8, %for.loop.idx10
  %6 = trunc i64 %5 to i24
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2, %for.loop
  %for.loop.idx39 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2 ]
  %dst.addr57 = getelementptr [3 x [3 x i8]], [3 x [3 x i8]]* %0, i64 0, i64 %for.loop.idx10, i64 %for.loop.idx39
  %src.addr681 = getelementptr [3 x i24], [3 x i24]* %1, i64 0, i64 %for.loop.idx39
  %7 = load i24, i24* %src.addr681, align 4
  %8 = lshr i24 %7, %6
  %9 = trunc i24 %8 to i8
  store i8 %9, i8* %dst.addr57, align 1
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond = icmp ne i64 %for.loop.idx3.next, 3
  br i1 %exitcond, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx10, 1
  %exitcond11 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond11, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_out([3 x [3 x i8]]* noalias "orig.arg.no"="0", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1", [3 x [3 x i8]]* noalias "orig.arg.no"="2", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3", [3 x [3 x i16]]* noalias "orig.arg.no"="4", [3 x [3 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #4 {
entry:
  call void @onebyonecpy_hls.p0a3a3i8.11.12([3 x [3 x i8]]* %0, [3 x i24]* align 512 %1)
  call void @onebyonecpy_hls.p0a3a3i8.13.14([3 x [3 x i8]]* %2, [3 x i24]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a3a3i16([3 x [3 x i16]]* %4, [3 x [3 x i16]]* align 512 %5)
  ret void
}

declare void @apatb_matrixmul_hw([3 x i24]*, [3 x i24]*, [3 x i16]*)

; Function Attrs: argmemonly noinline norecurse
define internal void @copy_back([3 x [3 x i8]]* noalias "orig.arg.no"="0", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="1", [3 x [3 x i8]]* noalias "orig.arg.no"="2", [3 x i24]* noalias readonly align 512 "fpga.caller.interfaces"="layout_transformed" "orig.arg.no"="3", [3 x [3 x i16]]* noalias "orig.arg.no"="4", [3 x [3 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a3a3i16([3 x [3 x i16]]* %4, [3 x [3 x i16]]* align 512 %5)
  ret void
}

define void @matrixmul_hw_stub_wrapper([3 x i24]*, [3 x i24]*, [3 x i16]*) #5 {
entry:
  %3 = alloca [3 x [3 x i8]]
  %4 = alloca [3 x [3 x i8]]
  %5 = bitcast [3 x i16]* %2 to [3 x [3 x i16]]*
  call void @copy_out([3 x [3 x i8]]* %3, [3 x i24]* %0, [3 x [3 x i8]]* %4, [3 x i24]* %1, [3 x [3 x i16]]* null, [3 x [3 x i16]]* %5)
  %6 = bitcast [3 x [3 x i8]]* %3 to [3 x i8]*
  %7 = bitcast [3 x [3 x i8]]* %4 to [3 x i8]*
  %8 = bitcast [3 x [3 x i16]]* %5 to [3 x i16]*
  call void @matrixmul_hw_stub([3 x i8]* %6, [3 x i8]* %7, [3 x i16]* %8)
  call void @copy_in([3 x [3 x i8]]* %3, [3 x i24]* %0, [3 x [3 x i8]]* %4, [3 x i24]* %1, [3 x [3 x i16]]* null, [3 x [3 x i16]]* %5)
  ret void
}

declare void @matrixmul_hw_stub([3 x i8]*, [3 x i8]*, [3 x i16]*)

attributes #0 = { inaccessiblememonly nounwind }
attributes #1 = { inaccessiblemem_or_argmemonly noinline "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !DILocation(line: 54, column: 9, scope: !6)
!6 = distinct !DISubprogram(name: "matrixmul", linkageName: "_Z9matrixmulPA3_cS0_PA3_s", scope: !7, file: !7, line: 48, type: !8, isLocal: false, isDefinition: true, scopeLine: 52, flags: DIFlagPrototyped, isOptimized: false, unit: !24, variables: !4)
!7 = !DIFile(filename: "matrixmul.cpp", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !17, !20}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 24, elements: !15)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_a_t", file: !13, line: 60, baseType: !14)
!13 = !DIFile(filename: "./matrixmul.h", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !{!16}
!16 = !DISubrange(count: 3)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 24, elements: !15)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_b_t", file: !13, line: 61, baseType: !14)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 48, elements: !15)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "result_t", file: !13, line: 62, baseType: !23)
!23 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!24 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !25, producer: "clang version 7.0.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, imports: !26)
!25 = !DIFile(filename: "D:/Courses/AAHLS_lab/labA/ug871-design-files/Design_Optimization/lab2/matrixmul_prj/solution1/.autopilot/db\5Cmatrixmul.pp.0.cpp", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!26 = !{!27, !35, !41, !43, !45, !49, !51, !53, !55, !57, !59, !61, !63, !68, !72, !74, !76, !81, !83, !85, !87, !89, !91, !93, !95, !98, !100, !104, !109, !111, !113, !115, !117, !119, !121, !123, !125, !127, !129, !133, !137, !139, !141, !143, !145, !147, !149, !151, !153, !155, !157, !159, !161, !163, !165, !167, !171, !175, !179, !181, !183, !185, !187, !189, !191, !193, !195, !197, !201, !205, !209, !211, !213, !215, !220, !224, !228, !230, !232, !234, !236, !238, !240, !242, !244, !246, !248, !250, !252, !257, !261, !265, !267, !269, !271, !277, !281, !285, !287, !289, !291, !293, !295, !297, !301, !305, !307, !309, !311, !313, !317, !321, !325, !327, !329, !331, !333, !335, !337, !341, !345, !349, !351, !355, !359, !361, !363, !365, !367, !369, !371}
!27 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !29, file: !34, line: 52)
!28 = !DINamespace(name: "std", scope: null)
!29 = !DISubprogram(name: "abs", scope: !30, file: !30, line: 254, type: !31, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!30 = !DIFile(filename: "D:/Courses/AAHLS/Vitis_HLS/2022.1/tps/mingw/8.3.0/win64.o/nt\5Cx86_64-w64-mingw32\5Cinclude\5Cmath.h", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!31 = !DISubroutineType(types: !32)
!32 = !{!33, !33}
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !DIFile(filename: "D:/Courses/AAHLS/Vitis_HLS/2022.1/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Cbits/std_abs.h", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!35 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !36, file: !40, line: 83)
!36 = !DISubprogram(name: "acos", scope: !30, file: !30, line: 190, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!37 = !DISubroutineType(types: !38)
!38 = !{!39, !39}
!39 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!40 = !DIFile(filename: "D:/Courses/AAHLS/Vitis_HLS/2022.1/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Ccmath", directory: "D:\5CCourses\5CAAHLS_lab\5ClabA\5Cug871-design-files\5CDesign_Optimization\5Clab2")
!41 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !42, file: !40, line: 102)
!42 = !DISubprogram(name: "asin", scope: !30, file: !30, line: 189, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!43 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !44, file: !40, line: 121)
!44 = !DISubprogram(name: "atan", scope: !30, file: !30, line: 191, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!45 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !46, file: !40, line: 140)
!46 = !DISubprogram(name: "atan2", scope: !30, file: !30, line: 192, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!47 = !DISubroutineType(types: !48)
!48 = !{!39, !39, !39}
!49 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !50, file: !40, line: 161)
!50 = !DISubprogram(name: "ceil", scope: !30, file: !30, line: 198, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!51 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !52, file: !40, line: 180)
!52 = !DISubprogram(name: "cos", scope: !30, file: !30, line: 184, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!53 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !54, file: !40, line: 199)
!54 = !DISubprogram(name: "cosh", scope: !30, file: !30, line: 187, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!55 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !56, file: !40, line: 218)
!56 = !DISubprogram(name: "exp", scope: !30, file: !30, line: 193, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!57 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !58, file: !40, line: 237)
!58 = !DISubprogram(name: "fabs", scope: !30, file: !30, line: 204, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!59 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !60, file: !40, line: 256)
!60 = !DISubprogram(name: "floor", scope: !30, file: !30, line: 199, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!61 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !62, file: !40, line: 275)
!62 = !DISubprogram(name: "fmod", scope: !30, file: !30, line: 246, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!63 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !64, file: !40, line: 296)
!64 = !DISubprogram(name: "frexp", scope: !30, file: !30, line: 244, type: !65, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!65 = !DISubroutineType(types: !66)
!66 = !{!39, !39, !67}
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!68 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !69, file: !40, line: 315)
!69 = !DISubprogram(name: "ldexp", scope: !30, file: !30, line: 243, type: !70, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!70 = !DISubroutineType(types: !71)
!71 = !{!39, !39, !33}
!72 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !73, file: !40, line: 334)
!73 = !DISubprogram(name: "log", scope: !30, file: !30, line: 194, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!74 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !75, file: !40, line: 353)
!75 = !DISubprogram(name: "log10", scope: !30, file: !30, line: 195, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!76 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !77, file: !40, line: 372)
!77 = !DISubprogram(name: "modf", scope: !30, file: !30, line: 245, type: !78, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!78 = !DISubroutineType(types: !79)
!79 = !{!39, !39, !80}
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!81 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !82, file: !40, line: 384)
!82 = !DISubprogram(name: "pow", scope: !30, file: !30, line: 196, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!83 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !84, file: !40, line: 421)
!84 = !DISubprogram(name: "sin", scope: !30, file: !30, line: 183, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!85 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !86, file: !40, line: 440)
!86 = !DISubprogram(name: "sinh", scope: !30, file: !30, line: 186, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!87 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !88, file: !40, line: 459)
!88 = !DISubprogram(name: "sqrt", scope: !30, file: !30, line: 197, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!89 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !90, file: !40, line: 478)
!90 = !DISubprogram(name: "tan", scope: !30, file: !30, line: 185, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!91 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !92, file: !40, line: 497)
!92 = !DISubprogram(name: "tanh", scope: !30, file: !30, line: 188, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!93 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !94, file: !40, line: 1065)
!94 = !DIDerivedType(tag: DW_TAG_typedef, name: "double_t", file: !30, line: 373, baseType: !39)
!95 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !96, file: !40, line: 1066)
!96 = !DIDerivedType(tag: DW_TAG_typedef, name: "float_t", file: !30, line: 372, baseType: !97)
!97 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!98 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !99, file: !40, line: 1069)
!99 = !DISubprogram(name: "acosh", scope: !30, file: !30, line: 705, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!100 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !101, file: !40, line: 1070)
!101 = !DISubprogram(name: "acoshf", scope: !30, file: !30, line: 706, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!102 = !DISubroutineType(types: !103)
!103 = !{!97, !97}
!104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !105, file: !40, line: 1071)
!105 = !DISubprogram(name: "acoshl", scope: !30, file: !30, line: 707, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!106 = !DISubroutineType(types: !107)
!107 = !{!108, !108}
!108 = !DIBasicType(name: "long double", size: 64, encoding: DW_ATE_float)
!109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !110, file: !40, line: 1073)
!110 = !DISubprogram(name: "asinh", scope: !30, file: !30, line: 710, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !112, file: !40, line: 1074)
!112 = !DISubprogram(name: "asinhf", scope: !30, file: !30, line: 711, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !114, file: !40, line: 1075)
!114 = !DISubprogram(name: "asinhl", scope: !30, file: !30, line: 712, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !116, file: !40, line: 1077)
!116 = !DISubprogram(name: "atanh", scope: !30, file: !30, line: 715, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !118, file: !40, line: 1078)
!118 = !DISubprogram(name: "atanhf", scope: !30, file: !30, line: 716, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!119 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !120, file: !40, line: 1079)
!120 = !DISubprogram(name: "atanhl", scope: !30, file: !30, line: 717, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !122, file: !40, line: 1081)
!122 = !DISubprogram(name: "cbrt", scope: !30, file: !30, line: 877, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !124, file: !40, line: 1082)
!124 = !DISubprogram(name: "cbrtf", scope: !30, file: !30, line: 878, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !126, file: !40, line: 1083)
!126 = !DISubprogram(name: "cbrtl", scope: !30, file: !30, line: 879, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !128, file: !40, line: 1085)
!128 = !DISubprogram(name: "copysign", scope: !30, file: !30, line: 1063, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !130, file: !40, line: 1086)
!130 = !DISubprogram(name: "copysignf", scope: !30, file: !30, line: 1064, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!131 = !DISubroutineType(types: !132)
!132 = !{!97, !97, !97}
!133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !134, file: !40, line: 1087)
!134 = !DISubprogram(name: "copysignl", scope: !30, file: !30, line: 1065, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!135 = !DISubroutineType(types: !136)
!136 = !{!108, !108, !108}
!137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !138, file: !40, line: 1089)
!138 = !DISubprogram(name: "erf", scope: !30, file: !30, line: 901, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!139 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !140, file: !40, line: 1090)
!140 = !DISubprogram(name: "erff", scope: !30, file: !30, line: 902, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !142, file: !40, line: 1091)
!142 = !DISubprogram(name: "erfl", scope: !30, file: !30, line: 903, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !144, file: !40, line: 1093)
!144 = !DISubprogram(name: "erfc", scope: !30, file: !30, line: 906, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!145 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !146, file: !40, line: 1094)
!146 = !DISubprogram(name: "erfcf", scope: !30, file: !30, line: 907, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !148, file: !40, line: 1095)
!148 = !DISubprogram(name: "erfcl", scope: !30, file: !30, line: 908, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !150, file: !40, line: 1097)
!150 = !DISubprogram(name: "exp2", scope: !30, file: !30, line: 728, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !152, file: !40, line: 1098)
!152 = !DISubprogram(name: "exp2f", scope: !30, file: !30, line: 729, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !154, file: !40, line: 1099)
!154 = !DISubprogram(name: "exp2l", scope: !30, file: !30, line: 730, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !156, file: !40, line: 1101)
!156 = !DISubprogram(name: "expm1", scope: !30, file: !30, line: 734, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !158, file: !40, line: 1102)
!158 = !DISubprogram(name: "expm1f", scope: !30, file: !30, line: 735, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !160, file: !40, line: 1103)
!160 = !DISubprogram(name: "expm1l", scope: !30, file: !30, line: 736, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !162, file: !40, line: 1105)
!162 = !DISubprogram(name: "fdim", scope: !30, file: !30, line: 1109, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !164, file: !40, line: 1106)
!164 = !DISubprogram(name: "fdimf", scope: !30, file: !30, line: 1110, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!165 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !166, file: !40, line: 1107)
!166 = !DISubprogram(name: "fdiml", scope: !30, file: !30, line: 1111, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !168, file: !40, line: 1109)
!168 = !DISubprogram(name: "fma", scope: !30, file: !30, line: 1130, type: !169, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!169 = !DISubroutineType(types: !170)
!170 = !{!39, !39, !39, !39}
!171 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !172, file: !40, line: 1110)
!172 = !DISubprogram(name: "fmaf", scope: !30, file: !30, line: 1131, type: !173, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!173 = !DISubroutineType(types: !174)
!174 = !{!97, !97, !97, !97}
!175 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !176, file: !40, line: 1111)
!176 = !DISubprogram(name: "fmal", scope: !30, file: !30, line: 1132, type: !177, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!177 = !DISubroutineType(types: !178)
!178 = !{!108, !108, !108, !108}
!179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !180, file: !40, line: 1113)
!180 = !DISubprogram(name: "fmax", scope: !30, file: !30, line: 1119, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !182, file: !40, line: 1114)
!182 = !DISubprogram(name: "fmaxf", scope: !30, file: !30, line: 1120, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !184, file: !40, line: 1115)
!184 = !DISubprogram(name: "fmaxl", scope: !30, file: !30, line: 1121, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !186, file: !40, line: 1117)
!186 = !DISubprogram(name: "fmin", scope: !30, file: !30, line: 1124, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !188, file: !40, line: 1118)
!188 = !DISubprogram(name: "fminf", scope: !30, file: !30, line: 1125, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !190, file: !40, line: 1119)
!190 = !DISubprogram(name: "fminl", scope: !30, file: !30, line: 1126, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !192, file: !40, line: 1121)
!192 = !DISubprogram(name: "hypot", scope: !30, file: !30, line: 882, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!193 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !194, file: !40, line: 1122)
!194 = !DISubprogram(name: "hypotf", scope: !30, file: !30, line: 883, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !196, file: !40, line: 1123)
!196 = !DISubprogram(name: "hypotl", scope: !30, file: !30, line: 887, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!197 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !198, file: !40, line: 1125)
!198 = !DISubprogram(name: "ilogb", scope: !30, file: !30, line: 748, type: !199, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!199 = !DISubroutineType(types: !200)
!200 = !{!33, !39}
!201 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !202, file: !40, line: 1126)
!202 = !DISubprogram(name: "ilogbf", scope: !30, file: !30, line: 749, type: !203, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!203 = !DISubroutineType(types: !204)
!204 = !{!33, !97}
!205 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !206, file: !40, line: 1127)
!206 = !DISubprogram(name: "ilogbl", scope: !30, file: !30, line: 750, type: !207, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!207 = !DISubroutineType(types: !208)
!208 = !{!33, !108}
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !210, file: !40, line: 1129)
!210 = !DISubprogram(name: "lgamma", scope: !30, file: !30, line: 911, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !212, file: !40, line: 1130)
!212 = !DISubprogram(name: "lgammaf", scope: !30, file: !30, line: 912, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!213 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !214, file: !40, line: 1131)
!214 = !DISubprogram(name: "lgammal", scope: !30, file: !30, line: 913, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !216, file: !40, line: 1134)
!216 = !DISubprogram(name: "llrint", scope: !30, file: !30, line: 946, type: !217, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!217 = !DISubroutineType(types: !218)
!218 = !{!219, !39}
!219 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !221, file: !40, line: 1135)
!221 = !DISubprogram(name: "llrintf", scope: !30, file: !30, line: 947, type: !222, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!222 = !DISubroutineType(types: !223)
!223 = !{!219, !97}
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !225, file: !40, line: 1136)
!225 = !DISubprogram(name: "llrintl", scope: !30, file: !30, line: 948, type: !226, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!226 = !DISubroutineType(types: !227)
!227 = !{!219, !108}
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !229, file: !40, line: 1138)
!229 = !DISubprogram(name: "llround", scope: !30, file: !30, line: 1038, type: !217, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !231, file: !40, line: 1139)
!231 = !DISubprogram(name: "llroundf", scope: !30, file: !30, line: 1039, type: !222, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !233, file: !40, line: 1140)
!233 = !DISubprogram(name: "llroundl", scope: !30, file: !30, line: 1040, type: !226, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !235, file: !40, line: 1143)
!235 = !DISubprogram(name: "log1p", scope: !30, file: !30, line: 768, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!236 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !237, file: !40, line: 1144)
!237 = !DISubprogram(name: "log1pf", scope: !30, file: !30, line: 769, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !239, file: !40, line: 1145)
!239 = !DISubprogram(name: "log1pl", scope: !30, file: !30, line: 770, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !241, file: !40, line: 1147)
!241 = !DISubprogram(name: "log2", scope: !30, file: !30, line: 773, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !243, file: !40, line: 1148)
!243 = !DISubprogram(name: "log2f", scope: !30, file: !30, line: 774, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !245, file: !40, line: 1149)
!245 = !DISubprogram(name: "log2l", scope: !30, file: !30, line: 775, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !247, file: !40, line: 1151)
!247 = !DISubprogram(name: "logb", scope: !30, file: !30, line: 778, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !249, file: !40, line: 1152)
!249 = !DISubprogram(name: "logbf", scope: !30, file: !30, line: 779, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !251, file: !40, line: 1153)
!251 = !DISubprogram(name: "logbl", scope: !30, file: !30, line: 780, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!252 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !253, file: !40, line: 1155)
!253 = !DISubprogram(name: "lrint", scope: !30, file: !30, line: 942, type: !254, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!254 = !DISubroutineType(types: !255)
!255 = !{!256, !39}
!256 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !258, file: !40, line: 1156)
!258 = !DISubprogram(name: "lrintf", scope: !30, file: !30, line: 943, type: !259, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!259 = !DISubroutineType(types: !260)
!260 = !{!256, !97}
!261 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !262, file: !40, line: 1157)
!262 = !DISubprogram(name: "lrintl", scope: !30, file: !30, line: 944, type: !263, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!263 = !DISubroutineType(types: !264)
!264 = !{!256, !108}
!265 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !266, file: !40, line: 1159)
!266 = !DISubprogram(name: "lround", scope: !30, file: !30, line: 1035, type: !254, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !268, file: !40, line: 1160)
!268 = !DISubprogram(name: "lroundf", scope: !30, file: !30, line: 1036, type: !259, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!269 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !270, file: !40, line: 1161)
!270 = !DISubprogram(name: "lroundl", scope: !30, file: !30, line: 1037, type: !263, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !272, file: !40, line: 1163)
!272 = !DISubprogram(name: "nan", scope: !30, file: !30, line: 1087, type: !273, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!273 = !DISubroutineType(types: !274)
!274 = !{!39, !275}
!275 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !276, size: 64)
!276 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !14)
!277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !278, file: !40, line: 1164)
!278 = !DISubprogram(name: "nanf", scope: !30, file: !30, line: 1088, type: !279, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!279 = !DISubroutineType(types: !280)
!280 = !{!97, !275}
!281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !282, file: !40, line: 1165)
!282 = !DISubprogram(name: "nanl", scope: !30, file: !30, line: 1089, type: !283, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!283 = !DISubroutineType(types: !284)
!284 = !{!108, !275}
!285 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !286, file: !40, line: 1167)
!286 = !DISubprogram(name: "nearbyint", scope: !30, file: !30, line: 931, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !288, file: !40, line: 1168)
!288 = !DISubprogram(name: "nearbyintf", scope: !30, file: !30, line: 932, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!289 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !290, file: !40, line: 1169)
!290 = !DISubprogram(name: "nearbyintl", scope: !30, file: !30, line: 933, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !292, file: !40, line: 1171)
!292 = !DISubprogram(name: "nextafter", scope: !30, file: !30, line: 1098, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !294, file: !40, line: 1172)
!294 = !DISubprogram(name: "nextafterf", scope: !30, file: !30, line: 1099, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !296, file: !40, line: 1173)
!296 = !DISubprogram(name: "nextafterl", scope: !30, file: !30, line: 1100, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !298, file: !40, line: 1175)
!298 = !DISubprogram(name: "nexttoward", scope: !30, file: !30, line: 1103, type: !299, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!299 = !DISubroutineType(types: !300)
!300 = !{!39, !39, !108}
!301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !302, file: !40, line: 1176)
!302 = !DISubprogram(name: "nexttowardf", scope: !30, file: !30, line: 1104, type: !303, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!303 = !DISubroutineType(types: !304)
!304 = !{!97, !97, !108}
!305 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !306, file: !40, line: 1177)
!306 = !DISubprogram(name: "nexttowardl", scope: !30, file: !30, line: 1105, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!307 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !308, file: !40, line: 1179)
!308 = !DISubprogram(name: "remainder", scope: !30, file: !30, line: 1053, type: !47, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !310, file: !40, line: 1180)
!310 = !DISubprogram(name: "remainderf", scope: !30, file: !30, line: 1054, type: !131, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!311 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !312, file: !40, line: 1181)
!312 = !DISubprogram(name: "remainderl", scope: !30, file: !30, line: 1055, type: !135, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!313 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !314, file: !40, line: 1183)
!314 = !DISubprogram(name: "remquo", scope: !30, file: !30, line: 1058, type: !315, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!315 = !DISubroutineType(types: !316)
!316 = !{!39, !39, !39, !67}
!317 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !318, file: !40, line: 1184)
!318 = !DISubprogram(name: "remquof", scope: !30, file: !30, line: 1059, type: !319, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!319 = !DISubroutineType(types: !320)
!320 = !{!97, !97, !97, !67}
!321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !322, file: !40, line: 1185)
!322 = !DISubprogram(name: "remquol", scope: !30, file: !30, line: 1060, type: !323, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!323 = !DISubroutineType(types: !324)
!324 = !{!108, !108, !108, !67}
!325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !326, file: !40, line: 1187)
!326 = !DISubprogram(name: "rint", scope: !30, file: !30, line: 937, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !328, file: !40, line: 1188)
!328 = !DISubprogram(name: "rintf", scope: !30, file: !30, line: 938, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !330, file: !40, line: 1189)
!330 = !DISubprogram(name: "rintl", scope: !30, file: !30, line: 939, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !332, file: !40, line: 1191)
!332 = !DISubprogram(name: "round", scope: !30, file: !30, line: 1030, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !334, file: !40, line: 1192)
!334 = !DISubprogram(name: "roundf", scope: !30, file: !30, line: 1031, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!335 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !336, file: !40, line: 1193)
!336 = !DISubprogram(name: "roundl", scope: !30, file: !30, line: 1032, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!337 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !338, file: !40, line: 1195)
!338 = !DISubprogram(name: "scalbln", scope: !30, file: !30, line: 871, type: !339, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!339 = !DISubroutineType(types: !340)
!340 = !{!39, !39, !256}
!341 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !342, file: !40, line: 1196)
!342 = !DISubprogram(name: "scalblnf", scope: !30, file: !30, line: 872, type: !343, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!343 = !DISubroutineType(types: !344)
!344 = !{!97, !97, !256}
!345 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !346, file: !40, line: 1197)
!346 = !DISubprogram(name: "scalblnl", scope: !30, file: !30, line: 873, type: !347, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!347 = !DISubroutineType(types: !348)
!348 = !{!108, !108, !256}
!349 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !350, file: !40, line: 1199)
!350 = !DISubprogram(name: "scalbn", scope: !30, file: !30, line: 867, type: !70, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !352, file: !40, line: 1200)
!352 = !DISubprogram(name: "scalbnf", scope: !30, file: !30, line: 868, type: !353, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!353 = !DISubroutineType(types: !354)
!354 = !{!97, !97, !33}
!355 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !356, file: !40, line: 1201)
!356 = !DISubprogram(name: "scalbnl", scope: !30, file: !30, line: 869, type: !357, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!357 = !DISubroutineType(types: !358)
!358 = !{!108, !108, !33}
!359 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !360, file: !40, line: 1203)
!360 = !DISubprogram(name: "tgamma", scope: !30, file: !30, line: 918, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!361 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !362, file: !40, line: 1204)
!362 = !DISubprogram(name: "tgammaf", scope: !30, file: !30, line: 919, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !364, file: !40, line: 1205)
!364 = !DISubprogram(name: "tgammal", scope: !30, file: !30, line: 920, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!365 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !366, file: !40, line: 1207)
!366 = !DISubprogram(name: "trunc", scope: !30, file: !30, line: 1044, type: !37, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!367 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !368, file: !40, line: 1208)
!368 = !DISubprogram(name: "truncf", scope: !30, file: !30, line: 1045, type: !102, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!369 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !28, entity: !370, file: !40, line: 1209)
!370 = !DISubprogram(name: "truncl", scope: !30, file: !30, line: 1046, type: !106, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!371 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !24, entity: !28, file: !13, line: 50)
!372 = !DILocation(line: 53, column: 9, scope: !6)
