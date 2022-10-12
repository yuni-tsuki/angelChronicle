class Gacha
    def initialize
        @angels = {:raphael => {:name => "ラファエル", :hierarchy => "熾天使", :hp => 230, :offence => 20},
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
        :normalangel => {:name => "エンジェル", :hierarchy => "天使", :hp => 60, :offence => 6}}
    end

    def pickACard(n)
        r = Random.new
        probability = r.rand(n)
        case probability
        when 0..1
            return @angels[:raphael]
        when 2..3
            return @angels[:michael]
        when 4..5
            return @angels[:gabriel]
        when 6..7
            return @angels[:uriel]
        when 8..12
            return @angels[:cherub]
        when 13..20
            return @angels[:throne]
        when 21..30
            return @angels[:dominion]
        when 31..45
            return @angels[:dynamis]
        when 46..55
            return @angels[:exsousia]
        when 56..65
            return @angels[:arkhai]
        when 66..80
            return @angels[:archangel]
        when 81..99
            return @angels[:normalangel]
        end
    end

    def fiveGacha
        deck = Array.new
        puts "5連ガチャを開始します。"
        for i in 1..5 do
            puts "―――#{i}枚目―――"
            deck.push(self.pickACard(99)) if i != 5
            deck.push(self.pickACard(20)) if i == 5
            print "#{deck[i - 1][:hierarchy]}#{deck[i - 1][:name]}を引いた！:"
            gets
        end
        return deck
    end
end

class Battle
    def initialize(deck)
        @deck = deck
    end

    def playersAttack(i,enemysHP)
        angelsOffence = @deck[i][:offence]
        puts "#{@deck[i][:name]}は#{angelsOffence}のダメージを与えた！"
        return enemysHP - angelsOffence
    end

    def battleScene
        enemysHP = 80
        angelsSumHP = 0

        for i in 0..4 do
            angelsSumHP += @deck[i][:hp]
        end

        puts "―――戦闘開始―――"
        print "敵のHPは#{enemysHP}です。:"
        gets
        puts "プレイヤーの攻撃！"

        for i in 0..4 do
            enemysHP = playersAttack(i, enemysHP)
        end

        print "敵の残りHPは#{enemysHP}です。:"
        gets

        if enemysHP >= 0
            puts "あなたは敵を倒せませんでした…"
        else
            puts "敵を倒しました！勝利です！"
        end
    end
end

print "エンジェルクロニクルをスタートします。Enterキーを押してください。:"
gets

gacha = Gacha.new

deck = gacha.fiveGacha

battle = Battle.new(deck)

battle.battleScene