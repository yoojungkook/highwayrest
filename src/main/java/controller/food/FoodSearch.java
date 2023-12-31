package controller.food;

import common.Handler;
import data.entity.RestFood;
import data.entity.Search;
import service.master.RestFoodService;
import service.search.SearchService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class FoodSearch implements Handler {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return null;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int searchType = Integer.parseInt(request.getParameter("searchType"));
        String num = request.getParameter("memberNo");
        String restNo = request.getParameter("restNo");
        String searchWord = request.getParameter("searchWord");
        String name = request.getParameter("name");

        if(num.isEmpty()){
            num = "0";
        }

        int memberNo = Integer.parseInt(num);

        if(memberNo != 0){
            SearchService searchService = new SearchService();
            searchService.addSearch(new Search(0, searchType, memberNo, null, searchWord));
        }

        RestFoodService restFoodService = new RestFoodService();
        ArrayList<RestFood> list = restFoodService.getByName(name, restNo);

        request.setAttribute("list", list);
        request.setAttribute("view", "/food/foodlist.jsp");
        return "/index.jsp";
    }

    @Override
    public String getPath() {
        return path + "/foodsearch";
    }
}
