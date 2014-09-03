#!/usr/bin/ruby
# -*- coding: utf-8 -*-

#------ 患者番号一覧取得


require 'crack' # for xml and json
require 'crack/xml' # for just xml
require 'uri'
require 'net/http'

Net::HTTP.version_1_2

HOST = "192.168.4.123"
PORT = "8000"
USER = "ormaster"
PASSWD = "ormaster123"
CONTENT_TYPE = "application/xml"

req = Net::HTTP::Post.new("/api01rv2/patientlst1v2?class=01")
# class :01 新規・更新対象
# class :02 新規対象
#
#
BODY = <<EOF



<data>
  <patientlst1req type="record">
  
  <Base_StartDate type="string">#{ARGV[0]}</Base_StartDate>
  <Base_EndDate type="string">#{ARGV[1]}</Base_EndDate>

  <Contain_TestPatient_Flag type="string">1</Contain_TestPatient_Flag>
  </patientlst1req>
</data>
EOF

def list_patient(body)


    
  
  puts "----------------------------"
  root = Crack::XML.parse(body)

  resulet= root["xmlio2"]["patientlst1res"]["Api_Result"]
  #unless result == "00"
  #  puts "error:#{result}"
  #  exit 1
  #end
  pinfo = root["xmlio2"]["patientlst1res"]["Patient_Information"]
  pinfo.each do |patient|
        print patient["Patient_ID"]
        print" "
	print patient["WholeName"]
print" "	
print patient["WholeName_inKana"]
print" "	
print patient["BirthDate"]
print" "	
print 
	if patient["Sex"] == "1"
	  puts "1"
	else
	  puts "2"
	end
#	print"  作成日　|"
#	puts patient["CreateDate"]
#	print"  更新日　|"
#	puts patient["UpdateDate"]
	puts "--------------------------"	
  end
end

	
	req.content_length = BODY.size
	req.content_type = CONTENT_TYPE
	req.body = BODY
	req.basic_auth(USER, PASSWD)
	
Net::HTTP.start(HOST, PORT) {|http|
  res = http.request(req)
  #puts res.code
  #puts res.body
  list_patient(res.body)
  

}
