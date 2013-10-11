module ApplicationHelper
		# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "Shooloo Learning"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}" 
		end
	end

	def liker_list(post)
		post.likers.map(&:screen_name).join(', ')
	end

	def comment_liker_list(comment)
		comment.likers.map(&:screen_name).join(', ')
	end

	def lesson_liker_list(lesson)
		lesson.likers.map(&:screen_name).join(', ')
	end

	def rater_list(post)
		post.raters.map(&:screen_name).join(', ')
	end

	def commenter_list(post)
		post.commenters.uniq.map(&:screen_name).join(', ')
	end

	def lesson_commenter_list(lesson)
		lesson.commenters.uniq.map(&:screen_name).join(', ')
	end

	def alert_count
		Activity.where(recipient_id: current_user.id).where('user_id not in (?)', 
			current_user.id).where(read: nil).count
	end
end

