mkdir -p build
rm build/*
nasm -f bin stage1.asm -o build/stage1.bin
nasm -f bin stage2.asm -o build/stage2.bin
cat build/stage1.bin build/stage2.bin > build/os.img
qemu-system-x86_64 -drive format=raw,file=build/os.img