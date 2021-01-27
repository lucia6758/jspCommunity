package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.mysqlutil.MysqlUtil;
import com.sbs.example.mysqlutil.SecSql;

public class ArticleDao {

	public List<Article> getForPrintArticlesByBoardId(int boardId, int limitStart, int limitCount, String searchKeyword,
			String searchKeywordType) {
		List<Article> articles = new ArrayList<>();

		SecSql sql = new SecSql();
		sql.append("SELECT A.*");
		sql.append(", M.name AS extra__writer");
		sql.append(", B.name AS extra__boardName");
		sql.append(", B.code AS extra__boardCode");
		sql.append("FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		if (boardId != 0) {
			sql.append("WHERE A.boardId = ?", boardId);
		}
		if (searchKeywordType != null) {
			if (searchKeywordType == null || searchKeywordType.equals("title")) {
				sql.append("AND title LIKE CONCAT('%',? '%')", searchKeyword);
			} else if (searchKeywordType.equals("body")) {
				sql.append("AND body LIKE CONCAT('%',? '%')", searchKeyword);
			} else if (searchKeywordType.equals("titleAndBody")) {
				sql.append("AND (title LIKE CONCAT('%',? '%') OR body LIKE CONCAT('%',? '%'))", searchKeyword,
						searchKeyword);
			}
		}
		sql.append("ORDER BY A.id DESC");

		if (limitCount != -1) {
			sql.append("LIMIT ?, ?", limitStart, limitCount);
		}

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> articleMap : articleMapList) {
			articles.add(new Article(articleMap));
		}

		return articles;
	}

	public Article getForPrintArticle(int id) {
		SecSql sql = new SecSql();
		sql.append("SELECT A.*");
		sql.append(", M.nickname AS extra__writer");
		sql.append(", B.name AS extra__boardName");
		sql.append(", B.code AS extra__boardCode");
		sql.append("FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("WHERE A.id = ?", id);
		sql.append("ORDER BY A.id DESC");
		Map<String, Object> articleMap = MysqlUtil.selectRow(sql);

		if (articleMap.isEmpty()) {
			return null;
		}

		return new Article(articleMap);
	}

	public int write(int memberId, String title, String body, int boardId) {
		SecSql sql = new SecSql();

		sql.append("INSERT INTO article");
		sql.append(" SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", boardId = ?", boardId);
		sql.append(", memberId = ?", memberId);
		sql.append(", title = ?", title);
		sql.append(", body = ?", body);

		return MysqlUtil.insert(sql);

	}

	public int modify(Map<String, Object> args) {
		SecSql sql = new SecSql();

		sql.append("UPDATE article");
		sql.append("SET updateDate = NOW()");

		boolean needToUpdate = false;

		if (args.get("title") != null) {
			needToUpdate = true;
			sql.append(", title = ?", args.get("title"));
		}
		if (args.get("body") != null) {
			needToUpdate = true;
			sql.append(", body = ?", args.get("body"));
		}
		if (needToUpdate == false) {
			return 0;
		}

		sql.append("WHERE id = ?", args.get("id"));

		return MysqlUtil.update(sql);
	}

	public int delete(int id) {
		SecSql sql = new SecSql();
		sql.append("DELETE");
		sql.append("FROM article");
		sql.append("WHERE id = ?", id);

		return MysqlUtil.delete(sql);
	}

	public Board getBoardById(int boardId) {
		SecSql sql = new SecSql();
		sql.append("SELECT *");
		sql.append("FROM board");
		sql.append("WHERE id = ?", boardId);

		Map<String, Object> map = MysqlUtil.selectRow(sql);

		if (map.isEmpty()) {
			return null;
		}

		return new Board(map);
	}

	public int getArticlesCountByBoardId(int boardId, String searchKeyword, String searchKeywordType) {
		SecSql sql = new SecSql();
		sql.append("SELECT COUNT(*) AS cnt");
		sql.append("FROM article");
		sql.append("WHERE 1");
		if (boardId != 0) {
			sql.append("AND boardId = ?", boardId);
		}

		if (searchKeyword != null) {
			if (searchKeywordType == null || searchKeywordType.equals("title")) {
				sql.append("AND title LIKE CONCAT('%',? '%')", searchKeyword);
			} else if (searchKeywordType.equals("body")) {
				sql.append("AND body LIKE CONCAT('%',? '%')", searchKeyword);
			} else if (searchKeywordType.equals("titleAndBody")) {
				sql.append("AND (title LIKE CONCAT('%',? '%') OR body LIKE CONCAT('%',? '%'))", searchKeyword,
						searchKeyword);
			}
		}

		return MysqlUtil.selectRowIntValue(sql);
	}

}
