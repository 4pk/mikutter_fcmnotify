# -*- coding: utf-8 -*-

# rubyなんも分からんのでほとんどゆずもねさんのパクリ

Plugin.create(:mikutter_fcmnotify) do

  on_favorite do |service, user, msg|
    # ポータル状態でif !user.me?にすると自分のふぁぼも通知される
    if msg.from_me?
      kana = {
        title: "Favorited by #{user.idname}",
        body: msg.description,
        url: msg.uri
      }
      # 意味不明な名前だけどこれでfcmをcallしてる
      nishino kana
    end
  end

  on_mention do |service ,msg|
    msg.each do |m|
      if Time.now - m.created < 10 and !m.retweet?
        kana = {
          title: "Mentioned by #{m.user.idname}",
          body: m.description,
          url: m.uri
        }
        nishino kana
      end
    end
  end

  on_retweet do |msg|
    msg.each do |m|
      if Time.now - m.created < 10
        m.retweet_source_d.next { |s|
          if s.from_me?
            kana = {
              title: "ReTweeted by #{m.user.idname}",
              body: s.description,
              url: s.uri
            }
            nishino kana
          end
        }
      end
    end
  end

  # 会いたくて震えると通知を1~50回重複させることが出来る
  # 会いたくて震えなければ通常の1回通知
  # 会いたくて震えるのに初期設定の0で使うと強制的に29回重複
  # ネーミングセンスどうにかしてると思う
  def nishino(data)
    if UserConfig[:how_many] == 0
      howmany = 29
    else
      howmany = UserConfig[:how_many]
    end
    if UserConfig[:nishinokana]
      i = 0
    else
      i = howmany - 1
    end
    while i < howmany do
      Plugin.call(:fcm, data)
      i = i + 1
    end
  end

  settings "mikutter_fcmnotify" do
    # 今のところここのチェックでふぁぼ，リプ，RTが全て重複される
    boolean "会いたくて震える", :nishinokana
    # 上限が50なのは泥の通知キューの上限が50なので
    adjustment "How many times", :how_many, 0, 50
  end
end
