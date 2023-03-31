#!/bin/bash

function installJq() {
    brew install jq
}
#
# json 파서 설치 체크
#
if hash identify 2>/dev/null && hash jq 2>/dev/null; then
    echo "----------------------------------    "
    echo "jsonparse already installed ✅        "
    echo "----------------------------------    "
else
    echo "-------------------------------    "
    echo "jsonparse is not installed💥     "
    echo "-------------------------------    "
    
    installJq
fi


PROJECT_DIR=${SRCROOT}/${PROJECT_NAME}
COLORSET_DIR=${PROJECT_DIR}/"PlatformLayer/Sources/TSCoreUI/Style/Assets.xcassets/ColorSet/*.colorset"

TARGET_FILE_NAME="TSStyle+Color.swift"
TARGET_FILE_DIR=${PROJECT_DIR}/"PlatformLayer/Sources/TSCoreUI/Style/$TARGET_FILE_NAME"

#echo $COLORSET_DIR
#echo $TARGET_FILE_NAME
#echo $TARGET_FILE_DIR

for file in $COLORSET_DIR ;do
file_name="${file##*/}"
file="${file_name%.*}"
echo "$file"
done

rm $TARGET_FILE_DIR
touch $TARGET_FILE_DIR

echo "// It is automatically created as 'ColorSet_Generator.sh'." >> $TARGET_FILE_DIR
echo "" >> $TARGET_FILE_DIR
echo "public extension TSStyle {" >> $TARGET_FILE_DIR
echo "    enum Color: String {" >> $TARGET_FILE_DIR

for file in $COLORSET_DIR ;do
full_file_name="${file##*/}"
file_name="${full_file_name%.*}"
chmod 755 "$file/Contents.json"

output_r=$(cat "$file/Contents.json" | jq -r .colors[0].color.components.red)
output_g=$(cat "$file/Contents.json" | jq -r .colors[0].color.components.green)
output_b=$(cat "$file/Contents.json" | jq -r .colors[0].color.components.blue)

echo "output_r : $output_r"
echo "        case $file_name // $output_r $output_g $output_b" >> $TARGET_FILE_DIR
done

echo "    }" >> $TARGET_FILE_DIR
echo "}" >> $TARGET_FILE_DIR
