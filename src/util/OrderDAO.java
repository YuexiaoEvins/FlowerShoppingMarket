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
    //���ҡ�����ȡ���ݿ������еĶ���
    public ArrayList<Order> getAllOrder(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Order> list = new ArrayList<>();  //��Ʒ����
        
        try{
        	OrderItemsDAO orderItemsDAO = new OrderItemsDAO(); 
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.order;";  //sql���
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                Order order = new Order();
                order.setOid(rs.getInt("oid"));
                order.setSum(rs.getInt("sum"));
                order.setUid(rs.getString("uid"));
                order.setUname(rs.getString("uname"));
                order.setOrderItemslist(orderItemsDAO.getAllItems(order.getOid()));
                
                list.add(order);  //���뼯��
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
    
    //�����û��Ż�ȡ���û�ȫ������
    public ArrayList<Order> getOrderByOid(String uid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Order> list = new ArrayList<>();  //��Ʒ����
        
        try{
            conn = DBHelper.getConnection();
            OrderItemsDAO orderItemsDAO = new OrderItemsDAO(); 
            String sql = "select * from shopping.order where uid=?;";  //sql���
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
                list.add(order);  //���뼯��
            }
            return list;
            
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
            String sql = "insert into shopping.order(oid,sum,uid,uname) values(?,?,?,?) ";  //sql���
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