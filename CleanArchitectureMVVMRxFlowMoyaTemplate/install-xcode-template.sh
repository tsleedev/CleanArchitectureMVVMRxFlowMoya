#!/usr/bin/env sh

# Configuration
XCODE_TEMPLATE_DIR=$HOME'/Library/Developer/Xcode/Templates/File Templates/CleanArchitectureMVVMRxFlowMoya'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy CleanArchitectureMVVMRxFlowMoya file templates into the local CleanArchitectureMVVMRxFlowMoya template directory
xcodeTemplate () {
  echo "==> Copying up CleanArchitectureMVVMRxFlowMoya Xcode file templates..."

  if [ -d "$XCODE_TEMPLATE_DIR" ]; then
    rm -R "$XCODE_TEMPLATE_DIR"
  fi
  mkdir -p "$XCODE_TEMPLATE_DIR"

  cp -R $SCRIPT_DIR/*.xctemplate "$XCODE_TEMPLATE_DIR"
  cp -R $SCRIPT_DIR/Scene\ \(Presentation\).xctemplate/Default/* "$XCODE_TEMPLATE_DIR/Scene (Presentation).xctemplate/withXIB/"
}

xcodeTemplate

echo "==> ... success!!"
echo "==> CleanArchitectureMVVMRxFlowMoya have been set up. In Xcode, select 'New File...' to use CleanArchitectureMVVMRxFlowMoya templates."
