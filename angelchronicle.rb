class EngelGacha
    def initialize 
        @engels = {
            :raphael => {:name => "ラファエル", :hierarchy => "熾天使", :hp => 230, :offence => 20},
            :michael => {:name => "ミカエル", :hierarchy => "熾天使", :hp => 200, :offence => 25},
            :gabriel => {:name => "ガブリエル", :hierarchy => "熾天使", :hp => 220, :offence => 20},
            :uriel => {:name => "ウリエル", :hierarchy => "熾天使", :hp => 200, :offence => 20},
            :cherub => {:name => "ケルビム", :hierarchy => "智天使", :hp => 180, :offence => 20},
            :throne => {:name => "ソロネ", :hierarchy => "座天使", :hp => 150, :offence => 17},
            :dominion => {:name => "ドミニオン", :hierarchy => "主天使", :hp => 120, :offence => 15},
            :dynamis => {:name => "ダイナミス", :hierarchy => "力天使", :hp => 100, :offence => 13},
            :exsousia => {:name => "エクスシーア", :hierarchy => "能天使", :hp => 90, :offence => 10},
            :arkhai => {:name => "アルケー", :hierarchy => "権天使", :hp => 80, :offence => 9},
            :archangel => {:name => "アークエンジェル", :hierarchy => "大天使", :hp => 70, :offence => 8},
            :normalangel => {:name => "エンジェル", :hierarchy => "天使", :hp => 60, :offence => 6}
        }
    end

    def pick_a_card(n)
        probability = rand(n)
        case probability
        when 0..1 then @engels[:raphael]
        when 2..3 then @engels[:michael]
        when 4..5 then @engels[:gabriel]
        when 6..7 then @engels[:uriel]
        when 8..12 then @engels[:cherub]
        when 13..20 then @engels[:throne]
        when 21..30 then @engels[:dominion]
        when 31..45 then @engels[:dynamis]
        when 46..55 then @engels[:exsousia]
        when 56..65 then @engels[:arkhai]
        when 66..80 then @engels[:archangel]
        else @engels[:normalangel]
        end
    end

    def five_gacha
        deck = Array.new #空のデッキを宣言
        puts "5連ガチャを開始します。"
        5.times do |i|
            puts "―――#{i + 1}枚目―――"
            deck.push(self.pick_a_card(i == 4 ? 20 : 99)) #5枚目のエンジェルはソロネ以上確定
            print "#{deck.last[:hierarchy]}#{deck.last[:name]}を引いた！:" #42行目で引いたエンジェルの階級と名前を表示
            gets
        end
        return deck
    end
end

class Battle
    def initialize(deck)
        @deck = deck
    end

    def players_attack(i,enemys_hp)
        engels_offence = @deck[i][:offence]
        puts "#{@deck[i][:name]}は#{engels_offence}のダメージを与えた！"
        return enemys_hp - engels_offence
    end

    def battle_scene
        enemys_hp = 300
        engels_sum_hp = @deck[0..4].sum { |engel| engel[:hp] }

        puts "―――戦闘開始―――"
        print "エンジェルのHPの合計は#{engels_sum_hp}、敵のHPは#{enemys_hp}です。:"
        gets

        4.times do
            puts "プレイヤーの攻撃！"

            for i in 0..4 do
                enemys_hp = players_attack(i, enemys_hp)
            end

            break if enemys_hp <= 0 #敵のHPが尽きると戦闘シーンを抜ける

            print "敵の残りHPは#{enemys_hp}です。:"
            gets

            puts "敵の攻撃！"

            enemys_attack = rand(50..90)
            engels_sum_hp -= enemys_attack

            puts "敵から#{enemys_attack}のダメージを食らった！"

            break if engels_sum_hp <= 0 #エンジェルのHPが尽きると戦闘シーンを抜ける

            print "エンジェルのHPは合計#{engels_sum_hp}です。:"
            gets
        end

        if enemys_hp >= 0
            puts "あなたは敵を倒せませんでした…"
        else
            puts "敵を倒しました！勝利です！"
        end
    end
end

print "エンジェルクロニクルをスタートします。Enterキーを押してください。:"
gets

gacha = EngelGacha.new

deck = gacha.five_gacha

battle = Battle.new(deck)

battle.battle_scene