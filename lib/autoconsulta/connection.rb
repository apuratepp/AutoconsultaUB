module Autoconsulta
  class Connect
    attr_accessor :cookie, :phpsessid
    
    URL = {
      :login =>         {:host => 'auten.ub.edu',     :port => 443, :path => '/uauten.pl'},
      :login2 =>        {:host => 'auten.ub.edu',     :port => 443, :path => '/auten.pl'},
      :identificacio => {:host => 'www.giga.ub.edu',  :port => 80,  :path => '/acad/cerca_ensto/identificacio2.php', :query => '?niub=10263643&danaix=21011984'},
      :expedient =>     {:host => 'www.giga.ub.edu',  :post => 80,  :path => '/acad/cerca_ensto/expedient.php'}
    }
    
    def initialize(params)
      @niub   = params[:niub]
      @danaix = params[:danaix]
      @idensy = params[:idensy]
      @user   = params[:user]
      @pass   = params[:pass]
      self.login_ub
    end

    def login_ub
      # http://stackoverflow.com/questions/1360808/rubys-open-uri-and-cookies
      http = Net::HTTP.new(URL[:login][:host], URL[:login][:port])
      http.use_ssl = true
      resp, data = http.post(URL[:login][:path], "user=#{@user}&password=#{@pass}", {})
      @cookie = resp.response['set-cookie']
      # p @cookie
      # puts resp.response.inspect
    end
  
    def get_ensenyaments
      http = Net::HTTP.new(URL[:identificacio][:host], URL[:identificacio][:port])
      headers = { "Cookie" => @cookie }
      resp, data = http.get(URL[:identificacio][:path] + "?niub=#{@niub}&danaix=#{@danaix}", headers)
      ensenyaments, @phpsessid = Autoconsulta::Parser.parse_ensenyaments(resp.body)
      puts "PHPSESSID: " + @phpsessid
      ensenyaments
    end
    
    def get_notes
      self.get_ensenyaments
      http = Net::HTTP.new(URL[:expedient][:host], URL[:expedient][:port])
      headers = { "Cookie" => @cookie }
      resp, data = http.get(URL[:expedient][:path] + "?niub=#{@niub}&danaix=#{@danaix}&idensy=#{@idensy}&PHPSESSID=#{@phpsessid}", headers)
      # p resp.body
      Autoconsulta::Parser.parse_notes(resp.body)
    end
        
  
  end
end