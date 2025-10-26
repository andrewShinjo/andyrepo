mkdir -p build
nasm -f bin boot.asm -o build/boot.bin
dd if=build/boot.bin of=build/boot.img bs=512 count=1
qemu-system-x86_64 -drive format=raw,file=build/boot.img