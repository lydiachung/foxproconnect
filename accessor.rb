require 'java'
require 'yaml'

java_import 'java.sql.DriverManager'

h_db_config = YAML.load_file('db.yml')

s_driver = "sun.jdbc.odbc.JdbcOdbcDriver"
s_url = %Q{jdbc:odbc:Driver={#{h_db_config["driver_name"]}};
  SourceType=DBC;
  SourceDB=#{h_db_config["dbc_full_name"]};}
puts s_url
o_conn = DriverManager.getConnection(s_url, "", "")


# insert
c_sql = %Q{insert into custprop (scope, userid, property, value, memovalue, lock, type) values ('test1','test2','test3','test4','test5','','')}
puts c_sql
o_stmt = o_conn.create_statement()
n_upd_cnt = o_stmt.execute_update(c_sql)
o_conn.commit()
o_stmt.close()

puts "#{n_upd_cnt} rows inserted"


# select
c_sql = %Q{select userid from custprop where property = 'test3'}
o_stmt = o_conn.create_statement()
o_rs = o_stmt.execute_query(c_sql)
if o_rs.next()
  puts "1 rows selected"
end
o_rs.close()
o_stmt.close()


# delete
c_sql = %Q{delete from custprop where property = 'test3'}
o_stmt = o_conn.create_statement()
n_del_cnt = o_stmt.execute_update(c_sql)
o_conn.commit()
o_stmt.close()
o_conn.close()

puts "#{n_upd_cnt} rows deleted"
