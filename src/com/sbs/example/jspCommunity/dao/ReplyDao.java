package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.dto.Reply;
import com.sbs.example.mysqlutil.MysqlUtil;
import com.sbs.example.mysqlutil.SecSql;

public class ReplyDao {

	public int doWrite(String relTypeCode, int relId, int loginedMemberId, String body) {
		SecSql sql = new SecSql();

		sql.append("INSERT INTO reply");
		sql.append(" SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", relTypeCode = ?", relTypeCode);
		sql.append(", relId = ?", relId);
		sql.append(", memberId = ?", loginedMemberId);
		sql.append(", body = ?", body);

		return MysqlUtil.insert(sql);
	}

	public List<Reply> getForPrintRepliesByRTCAndRelId(String relTypeCode, int relId) {
		List<Reply> replies = new ArrayList<>();

		SecSql sql = new SecSql();
		sql.append("SELECT R.*");
		sql.append(", M.nickname AS extra__writer");
		sql.append("FROM reply AS R");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON R.memberId = M.id");
		sql.append("WHERE R.relTypeCode = ?", relTypeCode);
		sql.append("AND R.relId = ?", relId);
		sql.append("ORDER BY R.id");

		List<Map<String, Object>> replyMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> replyMap : replyMapList) {
			replies.add(new Reply(replyMap));
		}

		return replies;
	}

	public Reply getReplyByReplyId(int id) {
		SecSql sql = new SecSql();
		sql.append("SELECT *");
		sql.append("FROM reply");
		sql.append("WHERE id = ?", id);

		Map<String, Object> map = MysqlUtil.selectRow(sql);

		if (map.isEmpty()) {
			return null;
		}

		return new Reply(map);
	}

	public void doDelete(int id) {
		SecSql sql = new SecSql();
		sql.append("DELETE");
		sql.append("FROM reply");
		sql.append("WHERE id = ?", id);

		MysqlUtil.delete(sql);
	}

	public void doModify(Map<String, Object> args) {
		SecSql sql = new SecSql();

		sql.append("UPDATE reply");
		sql.append("SET updateDate = NOW()");
		if (args.get("body") != null) {
			sql.append(", body = ?", args.get("body"));
		}
		sql.append("WHERE id = ?", args.get("id"));

		MysqlUtil.update(sql);
	}

}
