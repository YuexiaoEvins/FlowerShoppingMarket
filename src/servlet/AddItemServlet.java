package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

import javafx.scene.control.Alert;
import util.Items;
import util.ItemsDAO;
import util.Order;
import util.OrderDAO;
import util.OrderItems;
import util.User;
import util.UserDAO;

/**
 * Servlet implementation class AddItemServlet
 */
@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddItemServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		System.out.println(action);
		if (action==null) {
			action="";
		}
		

		if (action.equals("update")) {
			HashMap shoppingCar = (HashMap) session.getAttribute("shoppingCar");
			if (shoppingCar!=null) {
				String[] keys = request.getParameterValues("good_id");
				String[] num = request.getParameterValues("quantity");
				System.out.println(keys);
				System.out.println(num);
				if (keys!=null) {
					for (int i = 0; i < keys.length; i++) {
						if (keys[i] != null) { // 从Sessionn中读取购物车
							shoppingCar.put(Integer.parseInt(keys[i]), num[i]);

						}
					}
					session.setAttribute("shoppingCar", shoppingCar);
					out.print("<script>alert('更改购物车成功！');</script>");
				}
				else {
					out.print("<script>alert('请选中要修改的商品！');</script>");
				}
			}
			out.print("<script>window.location.href='cart.jsp'</script>");
			//response.sendRedirect("cart.jsp");
		}
		if (action.equals("Add")||action.equals("立即购买")) {
			// 读取表单传入的商品ID及数量
			int id = Integer.parseInt(request.getParameter("good_id"));
			String num = request.getParameter("quantity");

			if (String.valueOf(id) != null && num.length() != 0) { // 从Sessionn中读取购物车
				HashMap shoppingCar = (HashMap) session.getAttribute("shoppingCar");
				if (shoppingCar == null)
					shoppingCar = new HashMap();
				// 将商品加入到购物车中
				String onum = (String) shoppingCar.get(id);
				if (onum == null)
					shoppingCar.put(id, num);
				else {
					int n1 = Integer.parseInt(num);
					int n2 = Integer.parseInt(onum);
					String result = String.valueOf(n1 + n2);
					shoppingCar.put(id, result);
				}

				// 将购物车写回session中保存
				session.setAttribute("shoppingCar", shoppingCar);
				if (action.equals("立即购买")) {
					out.print("<script>alert('添加购物车成功！');window.location.href='cart.jsp'</script>");
				}
				else
					out.print("<script>alert('添加购物车成功！');window.location.href='details.jsp?id="+id+"'</script>");
				//response.sendRedirect("details.jsp?id=" + id + "");
				
			}
		}
		if (action.equals("delete")) {
			String[] id = request.getParameterValues("good_id");
			if (id!=null) {
				HashMap shoppingCar = (HashMap) session.getAttribute("shoppingCar");
				for (int i = 0; i < id.length; i++) {				
					if (String.valueOf(id[i]) != null) { // 从Sessionn中读取购物车
						System.out.println(Integer.parseInt(id[i]));
						
//						if (shoppingCar == null)
//							shoppingCar = new HashMap();
						// 将商品加入到购物车中
						shoppingCar.remove(Integer.parseInt(id[i]));
						// 将购物车写回session中保存
						
					}
				}
				session.setAttribute("shoppingCar", shoppingCar);
				
			}
			out.print("<script>alert('删除成功!');window.location.href='cart.jsp'</script>");
			//response.sendRedirect("cart.jsp");
			
		}
		//确认订单
		if (action.equals("ensure")) {
			HashMap shoppingCar = (HashMap) session.getAttribute("shoppingCar");
			User user = (User) session.getAttribute("user");
			if (shoppingCar!=null && user.getUid()!=null) {
				Order order = new Order();
				ArrayList<OrderItems> orderItemslist = new ArrayList<>();
				
				order.setUid(user.getUid());
				order.setUname(user.getUname());
				Date date = new Date();
		        Long t_times = date.getTime();
		        int times = t_times.intValue();
		        order.setOid(times+user.getUcount());
				

				int sum = 0;
				Items item = new Items();
				Iterator iterator = shoppingCar.entrySet().iterator();
				ItemsDAO itemsDAO = new ItemsDAO();
				while (iterator.hasNext()) {
					Map.Entry entry = (Map.Entry) iterator.next();
					int key = (int) entry.getKey();
					String temp_num = (String) entry.getValue();
					int num = Integer.parseInt(temp_num);
					item = itemsDAO.getItemById(key);
					itemsDAO.ChangeCount(key, num);
					sum += (num*item.getPrice());
					OrderItems orderItems2 = new OrderItems();
					orderItems2.setGid(item.getId());
					orderItems2.setGname(item.getName());
					orderItems2.setGnum(num);
					orderItems2.setGprice(item.getPrice());
					orderItems2.setGpicture(item.getPicture());
					System.out.println(orderItems2.getGname()+" "+orderItems2.getGid());
					orderItemslist.add(orderItems2);
				}
				order.setOrderItemslist(orderItemslist);
				order.setSum(sum);
				
				OrderDAO orderDAO = new OrderDAO();
				orderDAO.InsertOrder(order);
				
				shoppingCar=null;
				session.setAttribute("shoppingCar", shoppingCar);
				out.print("<script>alert('订单确认成功！');window.location.href='cart.jsp'</script>");
				//response.sendRedirect("cart.jsp");
			}
			else {
				//提示没有登录账号或者购物车为空
				//response.sendRedirect("cart.jsp");
				out.print("<script>alert('购物车为空，订单确认失败！');window.location.href='cart.jsp'</script>");
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
