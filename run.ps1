param ([Parameter(Mandatory)]$source_file,$vm_name="asmFun")
#VBoxManage controlvm $vm_name poweroff
#VBoxManage storageattach $vm_name --type=fdd --storagectl='Floppy' --device=0 --medium=none
VBoxManage controlvm $vm_name pause
wsl -e ./build.sh $source_file
VBoxManage controlvm $vm_name resume
VBoxManage controlvm $vm_name reset
#VBoxManage storageattach $vm_name --type=fdd --storagectl='Floppy' --device=0 --medium=./floppy.img
#VBoxManage startvm $vm_name
VBoxManage debugvm $vm_name getregisters eax
VBoxManage debugvm $vm_name getregisters ebx
VBoxManage debugvm $vm_name getregisters ecx
VBoxManage debugvm $vm_name getregisters edx
