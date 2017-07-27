from flask import Flask, url_for, abort
app = Flask(__name__)

@app.route('/')
def api_root():
    return 'Welcome'

@app.route('/articles')
def api_articles():
    return 'List of ' + url_for('api_articles')

@app.route('/certificate/<certificateid>')
def api_article(certificateid):
	if certificateid == '0x9748489E1BF1E3081D0B4BC3AC495D8B886F15872940C00E2ED475AD65E95C00':
	    return 'You are reading ' + certificateid
	else:
	    print('1')
	    abort(404)
            return 's'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='9999')

