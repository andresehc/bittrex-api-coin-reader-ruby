# Bid, ask, last source 1
# https://bittrex.com/api/v1.1/public/getticker

require 'rest-client'
require 'json'
require 'launchy'
require 'io/console'
require 'colorize'
class Coins
  attr_accessor :currency , :last, :volume, :bid , :ask, :high, :low
	# @@news_db = []
	@@coin_db = []

  def initialize currency , last, volume, bid , ask, high, low

    @currency = currency
    @last = last
    @volume = volume
    @bid = bid
    @ask = ask
    @high = high
    @low = low

  end


  def self.connect_api(source)
    url = source
    response = RestClient.get(url)
    JSON.parse response.body
    
  end

  def self.setup_db source
        self.connect_api(source)['result'].each do |x|
          @@coins_db << Coins.new(x['MarketName'], x['Last'], x['Volume'], x['Bid'], x['Ask'], x['High'], x['Low'])
        end
  end

  def self.actions ticker
      @@ticker = ticker
  	  @@coins_db = []
      setup_db('https://bittrex.com/api/v1.1/public/getmarketsummaries')
      show_all

  #   puts
  #   puts
  #   puts 'Choose an action'.colorize(:yellow)
  #   puts %{
  #     1) Show all Reddit news
  #     ------------------
  #     2) Show all Mashable news
  #     ------------------
  #     3) Show all Digg news
  #     ------------------
  #     4) Show all news by date
  #     ------------------
  #     E) Exit 
  # }.colorize(:red)
  #   case STDIN.getch.upcase
  #   when '1'
  #     @@news_db = []
  #     setup_db('https://www.reddit.com/.json',1)
  #     show_all 
  #   when '2'
  #     @@news_db = []
  #     setup_db('http://mashable.com/stories.json',2)
  #     show_all 
  #   when '3'
  #     @@news_db = []
  #     setup_db('http://digg.com/api/news/popular.json',3)
  #     show_all 
  #   when '4'
  #     @@news_db = []
  #     setup_db('https://www.reddit.com/.json',1)
  #     setup_db('http://mashable.com/stories.json',2)
  #     setup_db('http://digg.com/api/news/popular.json',3)
  #     @@news_db.sort! {|x,y| y.date <=> x.date}
  #     show_all
  #   when 'E'
  #     system("clear")
  #     return
  #   else
  #     self.actions
  #   end
  #   system("clear")
  #   self.actions
  end
  
  def self.show_all 
    system("clear")
    counter = 0
    @@coins_db.each { |x| 
    counter += 1
    if @@ticker == x.currency
    puts %{    -------------------------------------------------------------------------
    ------------------------------ Bittrex Feed--------------------------------
    -------------------------------------------------------------------------}.colorize(:blue)
      puts "\nTitle: #{x.currency}" 
      puts "Last: #{"%.8f" % x.last.to_s}"      
      puts "Volume: #{"%.8f" % x.volume.to_s}"  
      puts "Bid: #{"%.8f" % x.bid.to_s}"
      puts "Ask: #{"%.8f" % x.ask.to_s}"
      puts "High: #{"%.8f" % x.high.to_s}"
      puts "Low: #{"%.8f" % x.low.to_s}"
    end
      
      # answer = gets.chomp.upcase
      # if answer.to_i == counter   
      #   Launchy.open(x.url_news)
      #   system("clear")
      #   # actions
      # elsif answer == "B"
      #   return
      # end
      # system("clear")
    }

  end
  
end

