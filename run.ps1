param ([Parameter(Mandatory)]$source_file,$vm_name="asmFun")
VBoxManage startvm $vm_name
VBoxManage controlvm $vm_name pause
wsl -e ./build.sh $source_file
VBoxManage controlvm $vm_name resume
VBoxManage debugvm $vm_name getregisters eax
VBoxManage debugvm $vm_name getregisters ebx
VBoxManage debugvm $vm_name getregisters ecx
VBoxManage debugvm $vm_name getregisters edx
