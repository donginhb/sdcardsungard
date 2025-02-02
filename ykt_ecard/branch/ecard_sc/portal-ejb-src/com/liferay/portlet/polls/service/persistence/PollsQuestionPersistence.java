/**
 * Copyright (c) 2000-2005 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.liferay.portlet.polls.service.persistence;

import com.liferay.portal.SystemException;
import com.liferay.portal.service.persistence.BasePersistence;
import com.liferay.portal.util.HibernateUtil;

import com.liferay.portlet.polls.NoSuchQuestionException;

import com.liferay.util.dao.hibernate.OrderByComparator;
import com.liferay.util.lang.FastStringBuffer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * <a href="PollsQuestionPersistence.java.html"><b><i>View Source</i></b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.183 $
 *
 */
public class PollsQuestionPersistence extends BasePersistence {
	public com.liferay.portlet.polls.model.PollsQuestion create(
		String questionId) {
		return new com.liferay.portlet.polls.model.PollsQuestion(questionId);
	}

	public com.liferay.portlet.polls.model.PollsQuestion remove(
		String questionId) throws NoSuchQuestionException, SystemException {
		Session session = null;

		try {
			session = openSession();

			PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)session.get(PollsQuestionHBM.class,
					questionId);

			if (pollsQuestionHBM == null) {
				_log.warn("No PollsQuestion exists with the primary key of " +
					questionId.toString());
				throw new NoSuchQuestionException(questionId.toString());
			}

			com.liferay.portlet.polls.model.PollsQuestion pollsQuestion = PollsQuestionHBMUtil.model(pollsQuestionHBM);
			session.delete(pollsQuestionHBM);
			session.flush();
			PollsQuestionPool.remove(questionId);

			return pollsQuestion;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion update(
		com.liferay.portlet.polls.model.PollsQuestion pollsQuestion)
		throws SystemException {
		Session session = null;

		try {
			if (pollsQuestion.isNew() || pollsQuestion.isModified()) {
				session = openSession();

				if (pollsQuestion.isNew()) {
					PollsQuestionHBM pollsQuestionHBM = new PollsQuestionHBM(pollsQuestion.getQuestionId(),
							pollsQuestion.getPortletId(),
							pollsQuestion.getGroupId(),
							pollsQuestion.getCompanyId(),
							pollsQuestion.getUserId(),
							pollsQuestion.getUserName(),
							pollsQuestion.getCreateDate(),
							pollsQuestion.getModifiedDate(),
							pollsQuestion.getTitle(),
							pollsQuestion.getDescription(),
							pollsQuestion.getExpirationDate(),
							pollsQuestion.getLastVoteDate());
					session.save(pollsQuestionHBM);
					session.flush();
				}
				else {
					PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)session.get(PollsQuestionHBM.class,
							pollsQuestion.getPrimaryKey());

					if (pollsQuestionHBM != null) {
						pollsQuestionHBM.setPortletId(pollsQuestion.getPortletId());
						pollsQuestionHBM.setGroupId(pollsQuestion.getGroupId());
						pollsQuestionHBM.setCompanyId(pollsQuestion.getCompanyId());
						pollsQuestionHBM.setUserId(pollsQuestion.getUserId());
						pollsQuestionHBM.setUserName(pollsQuestion.getUserName());
						pollsQuestionHBM.setCreateDate(pollsQuestion.getCreateDate());
						pollsQuestionHBM.setModifiedDate(pollsQuestion.getModifiedDate());
						pollsQuestionHBM.setTitle(pollsQuestion.getTitle());
						pollsQuestionHBM.setDescription(pollsQuestion.getDescription());
						pollsQuestionHBM.setExpirationDate(pollsQuestion.getExpirationDate());
						pollsQuestionHBM.setLastVoteDate(pollsQuestion.getLastVoteDate());
						session.flush();
					}
					else {
						pollsQuestionHBM = new PollsQuestionHBM(pollsQuestion.getQuestionId(),
								pollsQuestion.getPortletId(),
								pollsQuestion.getGroupId(),
								pollsQuestion.getCompanyId(),
								pollsQuestion.getUserId(),
								pollsQuestion.getUserName(),
								pollsQuestion.getCreateDate(),
								pollsQuestion.getModifiedDate(),
								pollsQuestion.getTitle(),
								pollsQuestion.getDescription(),
								pollsQuestion.getExpirationDate(),
								pollsQuestion.getLastVoteDate());
						session.save(pollsQuestionHBM);
						session.flush();
					}
				}

				pollsQuestion.setNew(false);
				pollsQuestion.setModified(false);
				pollsQuestion.protect();
				PollsQuestionPool.put(pollsQuestion.getPrimaryKey(),
					pollsQuestion);
			}

			return pollsQuestion;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion findByPrimaryKey(
		String questionId) throws NoSuchQuestionException, SystemException {
		com.liferay.portlet.polls.model.PollsQuestion pollsQuestion = PollsQuestionPool.get(questionId);
		Session session = null;

		try {
			if (pollsQuestion == null) {
				session = openSession();

				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)session.get(PollsQuestionHBM.class,
						questionId);

				if (pollsQuestionHBM == null) {
					_log.warn(
						"No PollsQuestion exists with the primary key of " +
						questionId.toString());
					throw new NoSuchQuestionException(questionId.toString());
				}

				pollsQuestion = PollsQuestionHBMUtil.model(pollsQuestionHBM);
			}

			return pollsQuestion;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public List findByGroupId(String groupId) throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("groupId = ?");
			query.append(" ");
			query.append("ORDER BY ");
			query.append("createDate DESC");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, groupId);

			Iterator itr = q.list().iterator();
			List list = new ArrayList();

			while (itr.hasNext()) {
				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
				list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));
			}

			return list;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public List findByGroupId(String groupId, int begin, int end)
		throws SystemException {
		return findByGroupId(groupId, begin, end, null);
	}

	public List findByGroupId(String groupId, int begin, int end,
		OrderByComparator obc) throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("groupId = ?");
			query.append(" ");

			if (obc != null) {
				query.append("ORDER BY " + obc.getOrderBy());
			}
			else {
				query.append("ORDER BY ");
				query.append("createDate DESC");
			}

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, groupId);

			List list = new ArrayList();

			if (getDialect().supportsLimit()) {
				q.setMaxResults(end - begin);
				q.setFirstResult(begin);

				Iterator itr = q.list().iterator();

				while (itr.hasNext()) {
					PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
					list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));
				}
			}
			else {
				ScrollableResults sr = q.scroll();

				if (sr.first() && sr.scroll(begin)) {
					for (int i = begin; i < end; i++) {
						PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)sr.get(0);
						list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));

						if (!sr.next()) {
							break;
						}
					}
				}
			}

			return list;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion findByGroupId_First(
		String groupId, OrderByComparator obc)
		throws NoSuchQuestionException, SystemException {
		List list = findByGroupId(groupId, 0, 1, obc);

		if (list.size() == 0) {
			throw new NoSuchQuestionException();
		}
		else {
			return (com.liferay.portlet.polls.model.PollsQuestion)list.get(0);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion findByGroupId_Last(
		String groupId, OrderByComparator obc)
		throws NoSuchQuestionException, SystemException {
		int count = countByGroupId(groupId);
		List list = findByGroupId(groupId, count - 1, count, obc);

		if (list.size() == 0) {
			throw new NoSuchQuestionException();
		}
		else {
			return (com.liferay.portlet.polls.model.PollsQuestion)list.get(0);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion[] findByGroupId_PrevAndNext(
		String questionId, String groupId, OrderByComparator obc)
		throws NoSuchQuestionException, SystemException {
		com.liferay.portlet.polls.model.PollsQuestion pollsQuestion = findByPrimaryKey(questionId);
		int count = countByGroupId(groupId);
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("groupId = ?");
			query.append(" ");

			if (obc != null) {
				query.append("ORDER BY " + obc.getOrderBy());
			}
			else {
				query.append("ORDER BY ");
				query.append("createDate DESC");
			}

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, groupId);

			com.liferay.portlet.polls.model.PollsQuestion[] array = new com.liferay.portlet.polls.model.PollsQuestion[3];
			ScrollableResults sr = q.scroll();

			if (sr.first()) {
				while (true) {
					PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)sr.get(0);

					if (pollsQuestionHBM == null) {
						break;
					}

					com.liferay.portlet.polls.model.PollsQuestion curPollsQuestion =
						PollsQuestionHBMUtil.model(pollsQuestionHBM);
					int value = obc.compare(pollsQuestion, curPollsQuestion);

					if (value == 0) {
						if (!pollsQuestion.equals(curPollsQuestion)) {
							break;
						}

						array[1] = curPollsQuestion;

						if (sr.previous()) {
							array[0] = PollsQuestionHBMUtil.model((PollsQuestionHBM)sr.get(
										0));
						}

						sr.next();

						if (sr.next()) {
							array[2] = PollsQuestionHBMUtil.model((PollsQuestionHBM)sr.get(
										0));
						}

						break;
					}

					if (count == 1) {
						break;
					}

					count = (int)Math.ceil(count / 2.0);

					if (value < 0) {
						if (!sr.scroll(count * -1)) {
							break;
						}
					}
					else {
						if (!sr.scroll(count)) {
							break;
						}
					}
				}
			}

			return array;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public List findByP_G_C(String portletId, String groupId, String companyId)
		throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("portletId = ?");
			query.append(" AND ");
			query.append("groupId = ?");
			query.append(" AND ");
			query.append("companyId = ?");
			query.append(" ");
			query.append("ORDER BY ");
			query.append("createDate DESC");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, portletId);
			q.setString(queryPos++, groupId);
			q.setString(queryPos++, companyId);

			Iterator itr = q.list().iterator();
			List list = new ArrayList();

			while (itr.hasNext()) {
				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
				list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));
			}

			return list;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public List findByP_G_C(String portletId, String groupId, String companyId,
		int begin, int end) throws SystemException {
		return findByP_G_C(portletId, groupId, companyId, begin, end, null);
	}

	public List findByP_G_C(String portletId, String groupId, String companyId,
		int begin, int end, OrderByComparator obc) throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("portletId = ?");
			query.append(" AND ");
			query.append("groupId = ?");
			query.append(" AND ");
			query.append("companyId = ?");
			query.append(" ");

			if (obc != null) {
				query.append("ORDER BY " + obc.getOrderBy());
			}
			else {
				query.append("ORDER BY ");
				query.append("createDate DESC");
			}

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, portletId);
			q.setString(queryPos++, groupId);
			q.setString(queryPos++, companyId);

			List list = new ArrayList();

			if (getDialect().supportsLimit()) {
				q.setMaxResults(end - begin);
				q.setFirstResult(begin);

				Iterator itr = q.list().iterator();

				while (itr.hasNext()) {
					PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
					list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));
				}
			}
			else {
				ScrollableResults sr = q.scroll();

				if (sr.first() && sr.scroll(begin)) {
					for (int i = begin; i < end; i++) {
						PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)sr.get(0);
						list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));

						if (!sr.next()) {
							break;
						}
					}
				}
			}

			return list;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion findByP_G_C_First(
		String portletId, String groupId, String companyId,
		OrderByComparator obc) throws NoSuchQuestionException, SystemException {
		List list = findByP_G_C(portletId, groupId, companyId, 0, 1, obc);

		if (list.size() == 0) {
			throw new NoSuchQuestionException();
		}
		else {
			return (com.liferay.portlet.polls.model.PollsQuestion)list.get(0);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion findByP_G_C_Last(
		String portletId, String groupId, String companyId,
		OrderByComparator obc) throws NoSuchQuestionException, SystemException {
		int count = countByP_G_C(portletId, groupId, companyId);
		List list = findByP_G_C(portletId, groupId, companyId, count - 1,
				count, obc);

		if (list.size() == 0) {
			throw new NoSuchQuestionException();
		}
		else {
			return (com.liferay.portlet.polls.model.PollsQuestion)list.get(0);
		}
	}

	public com.liferay.portlet.polls.model.PollsQuestion[] findByP_G_C_PrevAndNext(
		String questionId, String portletId, String groupId, String companyId,
		OrderByComparator obc) throws NoSuchQuestionException, SystemException {
		com.liferay.portlet.polls.model.PollsQuestion pollsQuestion = findByPrimaryKey(questionId);
		int count = countByP_G_C(portletId, groupId, companyId);
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("portletId = ?");
			query.append(" AND ");
			query.append("groupId = ?");
			query.append(" AND ");
			query.append("companyId = ?");
			query.append(" ");

			if (obc != null) {
				query.append("ORDER BY " + obc.getOrderBy());
			}
			else {
				query.append("ORDER BY ");
				query.append("createDate DESC");
			}

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, portletId);
			q.setString(queryPos++, groupId);
			q.setString(queryPos++, companyId);

			com.liferay.portlet.polls.model.PollsQuestion[] array = new com.liferay.portlet.polls.model.PollsQuestion[3];
			ScrollableResults sr = q.scroll();

			if (sr.first()) {
				while (true) {
					PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)sr.get(0);

					if (pollsQuestionHBM == null) {
						break;
					}

					com.liferay.portlet.polls.model.PollsQuestion curPollsQuestion =
						PollsQuestionHBMUtil.model(pollsQuestionHBM);
					int value = obc.compare(pollsQuestion, curPollsQuestion);

					if (value == 0) {
						if (!pollsQuestion.equals(curPollsQuestion)) {
							break;
						}

						array[1] = curPollsQuestion;

						if (sr.previous()) {
							array[0] = PollsQuestionHBMUtil.model((PollsQuestionHBM)sr.get(
										0));
						}

						sr.next();

						if (sr.next()) {
							array[2] = PollsQuestionHBMUtil.model((PollsQuestionHBM)sr.get(
										0));
						}

						break;
					}

					if (count == 1) {
						break;
					}

					count = (int)Math.ceil(count / 2.0);

					if (value < 0) {
						if (!sr.scroll(count * -1)) {
							break;
						}
					}
					else {
						if (!sr.scroll(count)) {
							break;
						}
					}
				}
			}

			return array;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public List findAll() throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM ");
			query.append("ORDER BY ");
			query.append("createDate DESC");

			Query q = session.createQuery(query.toString());
			Iterator itr = q.iterate();
			List list = new ArrayList();

			while (itr.hasNext()) {
				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
				list.add(PollsQuestionHBMUtil.model(pollsQuestionHBM));
			}

			return list;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public void removeByGroupId(String groupId) throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("groupId = ?");
			query.append(" ");
			query.append("ORDER BY ");
			query.append("createDate DESC");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, groupId);

			Iterator itr = q.list().iterator();

			while (itr.hasNext()) {
				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
				PollsQuestionPool.remove((String)pollsQuestionHBM.getPrimaryKey());
				session.delete(pollsQuestionHBM);
			}

			session.flush();
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public void removeByP_G_C(String portletId, String groupId, String companyId)
		throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("portletId = ?");
			query.append(" AND ");
			query.append("groupId = ?");
			query.append(" AND ");
			query.append("companyId = ?");
			query.append(" ");
			query.append("ORDER BY ");
			query.append("createDate DESC");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, portletId);
			q.setString(queryPos++, groupId);
			q.setString(queryPos++, companyId);

			Iterator itr = q.list().iterator();

			while (itr.hasNext()) {
				PollsQuestionHBM pollsQuestionHBM = (PollsQuestionHBM)itr.next();
				PollsQuestionPool.remove((String)pollsQuestionHBM.getPrimaryKey());
				session.delete(pollsQuestionHBM);
			}

			session.flush();
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public int countByGroupId(String groupId) throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append("SELECT COUNT(*) ");
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("groupId = ?");
			query.append(" ");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, groupId);

			Iterator itr = q.list().iterator();

			if (itr.hasNext()) {
				Integer count = (Integer)itr.next();

				if (count != null) {
					return count.intValue();
				}
			}

			return 0;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	public int countByP_G_C(String portletId, String groupId, String companyId)
		throws SystemException {
		Session session = null;

		try {
			session = openSession();

			FastStringBuffer query = new FastStringBuffer();
			query.append("SELECT COUNT(*) ");
			query.append(
				"FROM PollsQuestion IN CLASS com.liferay.portlet.polls.service.persistence.PollsQuestionHBM WHERE ");
			query.append("portletId = ?");
			query.append(" AND ");
			query.append("groupId = ?");
			query.append(" AND ");
			query.append("companyId = ?");
			query.append(" ");

			Query q = session.createQuery(query.toString());
			int queryPos = 0;
			q.setString(queryPos++, portletId);
			q.setString(queryPos++, groupId);
			q.setString(queryPos++, companyId);

			Iterator itr = q.list().iterator();

			if (itr.hasNext()) {
				Integer count = (Integer)itr.next();

				if (count != null) {
					return count.intValue();
				}
			}

			return 0;
		}
		catch (HibernateException he) {
			throw new SystemException(he);
		}
		finally {
			HibernateUtil.closeSession(session);
		}
	}

	private static final Log _log = LogFactory.getLog(PollsQuestionPersistence.class);
}