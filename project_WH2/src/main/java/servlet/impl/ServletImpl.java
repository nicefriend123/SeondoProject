package servlet.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import servlet.service.ServletService;

@Service("ServletService")
public class ServletImpl extends EgovAbstractServiceImpl implements ServletService{
	
	@Resource(name="ServletDAO")
	private ServletDAO dao;
	
	@Override
	public String addStringTest(String str) throws Exception {
		List<EgovMap> mediaType = dao.selectAll();
		return str + " -> testImpl ";
	}

	@Override
	public List<Map<String, Object>> getSd() {
		return dao.getSd();
	}

	@Override
	public List<Map<String, Object>> sggList(String sd) {
		return dao.sgg(sd);
	}

	@Override
	public List<Map<String, Object>> bjdList(String sgg) {
		return dao.bjd(sgg);
	}

	@Override
	public List<Map<String, Object>> getGeomSd() {
		return dao.getGeomSd();
	}

}
