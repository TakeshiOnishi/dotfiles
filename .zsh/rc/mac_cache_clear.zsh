function mcc(){
  echo "### MacCacheClear [START] ###"
  NOW_DIR=$(cd $(dirname $0); pwd)

  cd ~/Library/Preferences
  mv com.apple.finder.plist com.apple.finder.plist_OLD
  qlmanage -r cache
  qlmanage -r
  killall Finder
  sleep 8s # plist生成までwait
  plutil -replace 'NewWindowTarget' -string 'PfDe' com.apple.finder.plist # 新規ウィンドウの設定(1/2)
  plutil -replace 'NewWindowTargetPath' -string "file://${HOME}/" com.apple.finder.plist # 新規ウィンドウの設定(2/2)
  killall Finder

  cd $NOW_DIR
  echo "### MacCacheClear [END] ###"
}
