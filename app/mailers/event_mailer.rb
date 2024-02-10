class EventMailer < ApplicationMailer
  def send_mail(title, content, group_id)
    # %% この名前はviews/event_mailer内にあるファイルと一緒にするべき %%
    @title = title
    @content = content
    @group = Group.find_by(id: group_id)
    @members = @group.users
    mail(to: @members.pluck(:email), subject: title)
    # byebug
  end
end
