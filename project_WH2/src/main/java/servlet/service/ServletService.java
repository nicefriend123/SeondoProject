package servlet.service;

import java.util.List;
import java.util.Map;

public interface ServletService {
	String addStringTest(String str) throws Exception;

	List<Map<String, Object>> getSd();

	List<Map<String, Object>> sggList(String sd);

	List<Map<String, Object>> bjdList(String sgg);

	List<Map<String, Object>> getGeomSd();

	void uploadFile(List<Map<String, Object>> list);

}
