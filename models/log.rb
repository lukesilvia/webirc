class Log
  def initialize(config)
    @config = config
  end
  
  def recent(limit = 20)
    fetch(limit)
  end
  
  def search(words, limit = 20)
    non_query_element = "\n"
    
    fetch(limit){|status|
      Array(words).all?{|w|
        [status[:nick], status[:message]].join(non_query_element).include?(w)
      }
    }
  end
  
  private
  
  def fetch(limit)
    statuses = []
    return statuses if limit == 0
    
    log_files.each do |path|
      date = extract_date(path)
      lines = File.readlines(path).reverse
      
      lines.each do |line|
        if m = line.match(Regexp.new(@config['status_regexp']))
          status = {
            :time    => "#{date} #{m[1]}",
            :nick    => m[2],
            :message => m[3]
          }
          
          if !block_given? || yield(status)
            statuses << status
            
            return statuses if statuses.size >= limit          
          end          
        end
      end      
    end
    
    statuses
  end
  
  def log_files
    Dir.glob("#{@config['log_dir']}/*").sort{|a, b| b <=> a }
  end
    
  def extract_date(path)
    filename = File.basename(path, '.txt')

    if m = filename.match(/(^\d{4}-\d{2}-\d{2})/)
      m[1]
    else
      nil
    end
  end
end
