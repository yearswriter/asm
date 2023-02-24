param ([Parameter(Mandatory)]$source_file,$vm_name="asmFun")
 try {
    $vm_output=@(VBoxManage controlvm $vm_name pause 2>&1)
    if ($LastExitCode) {
      write-host $vm_output
      $vm_output+=@(VBoxManage startvm $vm_name 2>&1)
      if ($LastExitCode) {
        throw "Could not launch VM"
      }
    }
  }
  catch {
    Write-Host "An error occurred:"
    Write-Host $vm_output
    Exit-PSHostProcess
  }
  finally {
    write-host $vm_output
    VBoxManage storageattach $vm_name --type=fdd --storagectl='Floppy' --device=0 --medium=./floppy.img
    VBoxManage controlvm $vm_name pause
  }
wsl -e ./build.sh $source_file
VBoxManage controlvm $vm_name resume
VBoxManage controlvm $vm_name reset
