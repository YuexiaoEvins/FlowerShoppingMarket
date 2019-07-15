package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

import util.DBHelper;

public class OrderItemsDAO{
    //��ȡ���ݿ���ָ�������ŵ���Ʒ����
    public ArrayList<OrderItems> getAllItems(int oid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<OrderItems> list = new ArrayList<>();  //��Ʒ����
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.orderitems where oid=?;";  //sql���
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
                list.add(orderItems);  //���뼯��
            }
            
            return list;  //���ؼ���
            
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
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
    
    //���붩������Ʒ���ϵ����ݿ�
    public void InsertOrderitems(int oid,ArrayList<OrderItems> orderItemslist){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try{
        	conn = DBHelper.getConnection();
        	Iterator iterator = orderItemslist.iterator();
        	while (iterator.hasNext()) {
				OrderItems orderItems = (OrderItems) iterator.next();
				String sql = "insert into shopping.orderitems(oid,gid,gname,gprice,gpicture,gnum) values(?,?,?,?,?,?)";  //sql���
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
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
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