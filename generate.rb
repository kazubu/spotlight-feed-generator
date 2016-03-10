#!/usr/bin/env ruby2.0

require 'net/http'
require 'resolv'
require 'pp'

STDOUT.sync = true

def exclude_addrs(addr)
  return true if addr == "::1"
  return true if addr == "127.0.0.1"
  return true if addr == "0.0.0.0"
  return false
end

def http_get(url)
  begin
    return Net::HTTP.get(URI.parse(url))
  rescue
  end
end

def get_from_hosts(url)
  dns = Resolv::DNS.new(:nameserver => ['8.8.8.8'], :ndots => 1)
  dns.timeouts = 1

  hosts = http_get(url)
  hosts.each_line{|line|
    next if line[0] == "#"
    ignore,host = line.split(' ')
    begin
      list = dns.getaddresses(host)
      list.each{|addr|
        addr = addr.to_s
        puts addr unless exclude_addrs(addr)
      }
    rescue
    end
  }
end

def get_from_iplist(url)
  result = []

  addrs = http_get(url)
  addrs.each_line{|line|
    puts line
  }
end



get_from_iplist "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset"
get_from_hosts "http://www.malwaredomainlist.com/hostslist/hosts.txt"
