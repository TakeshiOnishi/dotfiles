function mcc(){
  echo "### MacCacheClear [START] ###"
  NOW_DIR=$(cd $(dirname $0); pwd)

  cd ~/Library/Preferences
  mv com.apple.finder.plist com.apple.finder.plist_OLD

  qlmanage -r cache
  qlmanage -r
  sudo killall cfprefsd #plistCacheReset
  sleep 5s #生成までやや待ち
  setFinderOption
  sudo killall cfprefsd #plistCacheReset
  killall Finder

  cd $NOW_DIR
  echo "### MacCacheClear [END] ###"
}

# Finderのプロパティを上書きする関数
function setFinderOption(){
  # 上書きしたいプロパティが存在しているかチェック
  nwt_exist=$(plutil -extract 'NewWindowTarget' xml1  -o - com.apple.finder.plist | sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p")
  nwtp_exist=$(plutil -extract 'NewWindowTargetPath' xml1  -o - com.apple.finder.plist | sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p")
  fpvs_exist=$(plutil -extract 'FXPreferredViewStyle' xml1  -o - com.apple.finder.plist | sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p")

 # 新規ウィンドウの設定(1/2)
 if [ -z "$nwt_exist" ]; then
   plutil -insert 'NewWindowTarget' -string 'PfDe' com.apple.finder.plist
   echo "insert"
 else
   plutil -replace 'NewWindowTarget' -string 'PfDe' com.apple.finder.plist
   echo "repalce"
 fi

 # 新規ウィンドウの設定(2/2)
 if [ -z "$nwtp_exist" ]; then
   plutil -insert 'NewWindowTargetPath' -string "file://${HOME}/" com.apple.finder.plist
   echo "insert"
 else
   plutil -replace 'NewWindowTargetPath' -string "file://${HOME}/" com.apple.finder.plist
   echo "repalce"
 fi

 # ウィンドウのスタイルをリスト表示にする
 if [ -z "$fpvs_exist" ]; then
   plutil -insert 'FXPreferredViewStyle' -string 'Nlsv' com.apple.finder.plist
   echo "insert"
 else
   plutil -replace 'FXPreferredViewStyle' -string 'Nlsv' com.apple.finder.plist
   echo "repalce"
 fi
}
