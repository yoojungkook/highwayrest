package orders;

import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderDao {

    @Insert("INSERT INTO orders VALUES(seq_order.NEXTVAL, #{menu}, #{restNo}, #{pay}, #{memberNo}, #{ordersNo}, 0, sysdate)")
    int insert(Order order);

    @Select("SELECT seq_orders.NEXTVAL FROM dual")
    int getSeqOrders();

    @Select("SELECT * FROM orders WHERE memberno = #{memberNo} ORDER BY odate DESC")
    List<Order> findByMember(@Param("memberNo") int memberNo);

    @Select("SELECT * FROM orders WHERE rest LIKE '%#{rest}%'")
    List<Order> findByRest(@Param("rest") String rest);

    @Select("SELECT * FROM orders WHERE memberno = #{memberno} AND ordersNo = #{ordersNo}")
    List<Order> findMyOrders(Order order);

    @Update("UPDATE orders SET status = #{status} WHERE orderNo = #{orderNo}")
    int setStatus(Order order);

    @Update("UPDATE orders SET pay = #{pay} WHERE orderNo = #{orderNo}")
    int setPay(Order order);

}