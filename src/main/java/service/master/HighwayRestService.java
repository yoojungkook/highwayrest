package service.master;

import dao.master.HighwayRestDao;
import data.entity.HighwayRest;
import service.Service;

import java.util.ArrayList;

public class HighwayRestService extends Service {
    public void addHighwayRest(HighwayRest item) {
        sqlSession = sqlSessionFactory.openSession();
        HighwayRestDao dao = sqlSession.getMapper(HighwayRestDao.class);
        String svarCd = null;
        svarCd = dao.select(item.getSvarCd());

        if(svarCd == null)
            dao.insert(item);
        else
            System.out.println("이미 있는 휴게소입니다.");

        sqlSession.commit();
        sqlSession.close();
    }

    public HighwayRest getBySCd(String svarCd){
        sqlSession = sqlSessionFactory.openSession();
        HighwayRestDao dao = sqlSession.getMapper(HighwayRestDao.class);
        HighwayRest highwayRest = dao.selectBySCd(svarCd);

        sqlSession.close();

        return highwayRest;
    }

    public ArrayList<HighwayRest> getByRCd(String routeCd){
        sqlSession = sqlSessionFactory.openSession();
        HighwayRestDao dao = sqlSession.getMapper(HighwayRestDao.class);
        ArrayList<HighwayRest> list = dao.selectByRCd(routeCd);

        sqlSession.close();

        return list;
    }

    public ArrayList<HighwayRest> getByNm(String svarNm){
        sqlSession = sqlSessionFactory.openSession();
        HighwayRestDao dao = sqlSession.getMapper(HighwayRestDao.class);
        ArrayList<HighwayRest> list = dao.selectByNm("%" + svarNm + "%");

        sqlSession.close();

        return list;
    }

    public ArrayList<HighwayRest> getAll() {
        sqlSession = sqlSessionFactory.openSession();
        HighwayRestDao dao = sqlSession.getMapper(HighwayRestDao.class);
        ArrayList<HighwayRest> list = dao.selectAll();

        sqlSession.close();

        return list;
    }
}
