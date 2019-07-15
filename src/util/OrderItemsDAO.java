package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

import util.DBHelper;

public class OrderItemsDAO{
    //获取数据库内指定订单号的商品资料
    public ArrayList<OrderItems> getAllItems(int oid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<OrderItems> list = new ArrayList<>();  //商品集合
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.orderitems where oid=?;";  //sql语句
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, oid);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                OrderItems orderItems = new OrderItems();
                orderItems.setGid(rs.getInt("gid"));
                orderItems.setGname(rs.getString("gname"));
                orderItems.setGnum(rs.getInt("gnum"));
                orderItems.setGpicture(rs.getString("gpicture"));
                orderItems.setGprice(rs.getInt("gprice"));
                list.add(orderItems);  //加入集合
            }
            
            return list;  //返回集合
            
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }finally{
            //释放数据集对象
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //释放语句对象
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
    }
    
    //插入订单的商品资料到数据库
    public void InsertOrderitems(int oid,ArrayList<OrderItems> orderItemslist){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try{
        	conn = DBHelper.getConnection();
        	Iterator iterator = orderItemslist.iterator();
        	while (iterator.hasNext()) {
				OrderItems orderItems = (OrderItems) iterator.next();
				String sql = "insert into shopping.orderitems(oid,gid,gname,gprice,gpicture,gnum) values(?,?,?,?,?,?)";  //sql语句
	            stmt = conn.prepareStatement(sql);
	            stmt.setInt(1,oid);
	            stmt.setInt(2, orderItems.getGid());
	            stmt.setString(3, orderItems.getGname());
	            stmt.setInt(4, orderItems.getGprice());
	            stmt.setString(5, orderItems.getGpicture());
	            stmt.setInt(6, orderItems.getGnum());     
	            System.out.println(orderItems.getGid()+" "+orderItems.getGname());
	            stmt.executeUpdate();;
			}
                        
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            //释放数据集对象
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //释放语句对象
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
    }
    
}