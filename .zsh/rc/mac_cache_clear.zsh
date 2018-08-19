function mcc(){
  echo "### MacCacheClear [START] ###"
  NOW_DIR=$(cd $(dirname $0); pwd)

  cd ~/Library/Preferences
  mv com.apple.finder.plist com.apple.finder.plist_OLD
  killall Finder
  qlmanage -r cache
  qlmanage -r

  cd $NOW_DIR
  echo "### MacCacheClear [END] ###"
}
