package util;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.Order;
import util.DBHelper;
import util.*;

public class OrderDAO{
    //卖家——获取数据库内所有的订单
    public ArrayList<Order> getAllOrder(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Order> list = new ArrayList<>();  //商品集合
        
        try{
        	OrderItemsDAO orderItemsDAO = new OrderItemsDAO(); 
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.order;";  //sql语句
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                Order order = new Order();
                order.setOid(rs.getInt("oid"));
                order.setSum(rs.getInt("sum"));
                order.setUid(rs.getString("uid"));
                order.setUname(rs.getString("uname"));
                order.setOrderItemslist(orderItemsDAO.getAllItems(order.getOid()));
                
                list.add(order);  //加入集合
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
    
    //根据用户号获取该用户全部订单
    public ArrayList<Order> getOrderByOid(String uid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Order> list = new ArrayList<>();  //商品集合
        
        try{
            conn = DBHelper.getConnection();
            OrderItemsDAO orderItemsDAO = new OrderItemsDAO(); 
            String sql = "select * from shopping.order where uid=?;";  //sql语句
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,uid);
            rs = stmt.executeQuery();
            while(rs.next()){
                Order order = new Order();
                order.setOid(rs.getInt("oid"));
                order.setUid(rs.getString("uid"));
                order.setSum(rs.getInt("sum"));
                order.setUname(rs.getString("uname"));
                order.setOrderItemslist(orderItemsDAO.getAllItems(order.getOid()));
                list.add(order);  //加入集合
            }
            return list;
            
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
    public void InsertOrder(Order order){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        OrderItemsDAO orderItemsDAO = new OrderItemsDAO();
        Date date = new Date();
        Long t_times = date.getTime();
        int times = t_times.intValue();
        try{
            conn = DBHelper.getConnection();
            String sql = "insert into shopping.order(oid,sum,uid,uname) values(?,?,?,?) ";  //sql语句
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, order.getOid());
            stmt.setInt(2, order.getSum());
            stmt.setString(3, order.getUid());
            stmt.setString(4, order.getUname());        
            stmt.executeUpdate();
            System.out.println(order.getOid()+" "+order.getUid()+" "+order.getSum()+" "+order.getUname());
            orderItemsDAO.InsertOrderitems(order.getOid(), order.getOrderItemslist());
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