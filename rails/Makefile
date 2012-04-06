PRODUCTION_HOST=voze.org
PRODUCTION_USER=voze
PRODUCTION_DIR=/srv/http/voze/rails

deploy:
	ssh $(PRODUCTION_USER)@$(PRODUCTION_HOST) \
		'cd $(PRODUCTION_DIR) && git pull --rebase && make prod-deploy'

# all targets starting with prod- are intended to be run automatically on the
# production machine. do not run them manually

prod-deploy:
	sudo bundle install
	bundle exec rake assets:precompile RAILS_ENV=production
	bundle exec rake db:migrate RAILS_ENV=production
	touch tmp/restart.txt