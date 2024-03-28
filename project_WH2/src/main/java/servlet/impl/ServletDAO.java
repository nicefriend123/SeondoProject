package servlet.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("ServletDAO")
public class ServletDAO extends EgovComAbstractDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public List<EgovMap> selectAll() {
		return selectList("servlet.serVletTest");
	}

	public List<Map<String, Object>> getSd() {
		return session.selectList("servlet.getSd");
	}

	public List<Map<String, Object>> sgg(String sd) {
		return selectList("servlet.sgg", sd);
	}

	public List<Map<String, Object>> bjd(String sgg) {
		return selectList("servlet.bjd", sgg);
	}

	public List<Map<String, Object>> getGeomSd() {
		return selectList("servlet.getGeomSd");
	}

	public void uploadFile(List<Map<String, Object>> list) {
		insert("filUpload.uploadFile", list);
	}

}
