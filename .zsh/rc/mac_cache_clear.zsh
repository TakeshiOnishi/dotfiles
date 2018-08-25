# MacCacheClear (for Finder)
function mcc(){
  # もはやCacheクリアというより、設定ファイル再配置になったのでいつか分解する
  
  echo "### MacCacheClear [START] ###"
  NOW_DIR=$(cd $(dirname $0); pwd)

  cd ~/Library/Preferences
  mv com.apple.finder.plist com.apple.finder.plist_OLD

  qlmanage -r cache
  qlmanage -r
  sudo killall cfprefsd #plistCacheReset
  sleep 5s #生成までやや待ち
  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
  defaults write com.apple.finder ShowRecentTags -bool false
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true #Finderではないが追加 (.DSファイルを書き込まない)
  killall Finder

  cd $NOW_DIR
  echo "### MacCacheClear [END] ###"
}
