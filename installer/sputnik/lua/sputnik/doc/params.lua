module(..., package.seeall)

topics = {}

topics.authentication = [[
Sputnik can be configured to use alternative authentication modules.

AUTH_MODULE
   Authentication module to be used for authentication. E.g.

       AUTH_MODULE = "sputnik.auth.luasql"

AUTH_MODULE_PARAMS
   Parameters to be passed to the authentication module. E.g.:

       AUTH_MODULE_PARAMS = {
          "sqlite", "/tmp/sputnik.db"
       }

   Those parameters are module-specific.
   
See also "cryptography".
]]

topics.cryptography = [[
Two salt parameters need to be set for Sputnik's encryption needs. You
also may want to opt to use the more secure POSIX crypt function for
password hashing rather than the default MD5.

TOKEN_SALT

    A secret code that will be used for encryption in cookies,
    etc. Any long string would do, e.g.:
     
        TOKEN_SALT = "zv4N4d6BCs9Znts5NJ01eAvhzUW0TqgjMbWGeT8H"
    
    "sputnik make-cgi" will generates a value for you automatically.

PASSWORD_SALT

    A optional salt parameter to be used for hashing functions. If you
    later want to reuse your MD5-hashed password file on a different
    Sputnik installation, you will need to use the same
    PASSWORD_TOKEN.

USE_POSIX_CRYPT

    If set to true, Sputnik will use POSIX crypt() function provided
    by luaposix. This is more secure than using MD5 and makes it
    possible to reuse password hashes generated by other applications
    using crypt(). However, it requres luaposix, which is not
    available on all platforms.

]]

topics.node_names = [[
There is a large number of parameters that control the names for
different system nodes. There would normally be no reason to change
any of them.

ROOT_PROTOTYPE
    The node to be used as the root prototype. (The default is
    "@Root".)

ADMIN_NODE_PREFIX
    The prefix for admin nodes. (The default is "sputnik/".)

DEFAULT_NAVIGATION_BAR
    The node that stores the navigation bar. (The default is
    "sputnik/navigation.")
    
PASSWORD_RESET_NODE
    The node used for resetting password. (The default is
    "sputnik/password_reset".)
    
REGISTRATION_NODE
    The node for new user registration. (The default is
    "sputnik/register".)

CONFIG_PAGE_NAME
    The configration node. (The default is "sputnik/config".)

LOGIN_NODE
    The login node. (The default is "sputnik/login".)
    
LOGOUT_NODE
    The logout node. (The default is "sputnik/logout".)

HOME_PAGE
    The "home page" node - that is, the node that is displayed when
    none is specified. (The default is "index".)
    
FAVICON_NODE
    The node where the favicon is stored. (The default is
    "icons/sputnik.png".)

HISTORY_PAGE
    The node displaying history for the whole wiki. (The default is
    "history".)
]]

topics.smtp = [[
If you want Sputnik to send email (e.g. for registration confirmation
or password recovery), you need to configure SMTP parameters.

SMTP_SERVER
    SMTP server's host name. (The default is "localhost".)

SMTP_SERVER_PORT
    SMTP server port number. (The default is 25.)

SMTP_USER
    SMTP server username. (Must be specified.)
    
SMTP_PASSWORD
    SMTP user password. (Must be specified.)

EMAIL_TEST_MODE
    If set to true, no emails will be sent. Instead, the information
    would be printed to stdout. (Useful for debugging.)
]]

topics.app_cache = [[
A Sputnik-based application may need to do its own caching. For those
purposes, a additional storage engine can be initialized to be used as
an "app cache".

APP_CACHE_STORAGE_MODULE
    Storage module to be used for the application cache.

APP_CACHE_PARAMS = {
    Parameters to be passed to the application cache module.

See also "storage".
]]

topics.cache = [[
Sputnik can be configured to do caching by providing a cache module.

CACHE_MODULE
    Module to be used for caching.
    
CACHE_MODULE_PARAMS
   Parameters to be passed to the cache module.
]]

topics.storage = [[
Two parameters must be set to tell Sputnik where to store node data.

VERSIUM_STORAGE_MODULE
    The module to be used for storing node data. The default is
    "versium.storage.filedir", which stores node data as files in
    directories.  Other options include:
    
        versium.storage.mysql
            uses a mysql database, requires "luasql.mysql";
        versium.storage.sqlite3
            uses a sqlite3 database, requires "luasql.sqlite3";
        versium.storage.git
            uses git;
        versium.keyvalue
            uses a generic key-value storage backend.

VERSIUM_PARAMS
    Parameters for initializing the storage module. Those are
    module-specific.
    
    For the default "filedir" this would be just the directory name
    where data is to be stored, e.g.:

        VERSIUM_PARAMS  = {"/home/bob/sputnik/wiki-data/"},
        
    For sqlite3 its the sqlite3 database file:

        VERSIUM_PARAMS  = {"/home/bob/sputnik/wiki-data.db"},
     
    For mysql it's the parameters required by luasql.mysql.

]]

topics.urls = [[
Sputnik needs a way to generate links to itself. The most important
parameter for this is BASE_URL, which specifies the URL of the current
Sputnik instance relative to the server's root. An additional optional
parameter USE_NICE_URLS specifies how node ids are incorporated into
the URL. If USE_NICE_URLS is true, then the node ids are appended to
BASE_URL and are treated as a part of the "script path" (e.g.,
"/wiki/Some_Page"). If USE_NICE_URLS is false, the node ids is passed
as one of query parameters ("p", e.g. "/wiki?p=Some_Page").

There is also a number of parameters that can be used to point Sputnik
to resources such as images, CSS, etc. stored at some other path.

BASE_URL
    The base for Sputnik's URLs. (See above.) The choice of BASE_URL
    will depend on the server used.
     
USE_NICE_URLS = {
    Specifies whether "nice" URLs should be used. (See above.)
    
DIRIFY_FN
    A function that can be used to change a string so that it could be
    used as a node name. The default function replaces characters with
    underscores.
    
DOMAIN
    The domain on which Sputnik is running, e.g., "mydomain.com". When
    set this value is used for generating fully qualified URLs. This
    is necessary for RSS and email activation / password reset to
    work.

HOME_PAGE_URL
    The main URL of the site. (E.g., this is the URL that will be
    linked from the logo.)

FAVICON_URL
    An alternative URL for the favicon.
    
CSS_BASE_URL
    An alternative prefix at which CSS files are served. You should
    set this if you want to serve them statically.

JS_BASE_URL
    An alternative prefix at which Javascript files are served. You
    should set this if you want to serve them statically.

ICON_BASE_URL
    An alternative prefix at which icon files are served. You should
    set this if you want to serve them statically.
    
FONT_BASE_URL
    An alternative prefix at which font files are served. You should
    set this if you want to serve them statically.

]]

topics.captcha = [[
Sputnik in theory offers you a way of plugging in different captcha
solutions, but at the moment there is only one option: ReCapatcha.

CAPTCHA_MODULE
    The module to be used for captcha. Right now the only included
    option is recaptca (http://recaptcha.net/). The module "repatcha"
    needs to be installed for it to work.

CAPTCHA_PARAMS
    Module specific initialization parameters. For recaptcha this is a
    table with two values: a public and a private key that need to be
    obtained from recaptcha.net. E.g.:
    
        CAPTCHA_PARAMS = {
            "6LdcBAIAAA37AAAH705JU7ad31hHT9837276KO_prDaN", -- public key
            "6LdcBAIAAAAAAFz7j92783ij083728372727DMQQt5",   -- private key
        }  
]]

topics.registration = [[
Sputnik can be configured to require new users to activate their
accounts by clicking on a link in an a message sent to the email
address they specify.  Registration can also be disabled
altogether. Users may be required to accept terms of service.

DISABLE_REGISTRATION
    If set to true, new user registration will be turned off.
    
TERMS_OF_SERVICE_NODE
    The node that stores terms of service. If this parameter is set,
    new users will be asked to check off a checkbox saying that they
    accept the terms.  (This node probably should not be editable by
    regular users.)
    
REQUIRE_EMAIL_ACTIVATION
    If set to true, new users will be required to provide an email
    address when they register. They will then be sent an email with a
    link and will need to click on the link to activate their
    accounts. This requires smtp parameters to be set.
    
REGISTRATION_EMAIL_FROM
    The name and email address from which activation emails will be
    set, e.g. "Igor da Silva <igor@example.com>".

REGISTRATION_EMAIL_BCC
    An address or a table of addresses that would be BCCed on all
    activation emails.

MAX_ACTIVATION_ATTEMPTS
    The number of tries the user before account activation ticket is
    invalidated. (The default is 3.)

USERNAME_RULES
    Can be set to a table of functions that would be used to test if a
    new username is acceptable. (Each function would need to return
    true is the username is acceptable and false if it is not.)
    
PASSWORD_RULES 
    Can be set to a table of fuctions that would be used to test if a
    new password is acceptable. (Each function would need to return
    true is the password is acceptable and false if it is not.) For
    example, a function could test if the password is longer than some
    minimum length, contains digits, etc.

See also "smtp".

]]

topics.logging = [[
Sputnik can be set to log via lualogging. See LuaLogging web site
(http://www.keplerproject.org/lualogging/) for more information.

LOGGER
    LuaLogging "logger". E.g., "console", "file", or "email".
    
LOGGER_LEVEL
    Logging level, e.g., logging.WARN.
    
LOGGER_PARAMS
    Logger-specific initialization parameters.

]]

topics.markup = [[
Sputnik can use different markups modules.

MARKUP_MODULE
    The module to be used for converting wiki page source into
    HTML. The default is "sputnik.markup.markdown", which uses
    markdown.

]]

topics.interwiki = [=[
Sputnik can be configured to use Interwiki links.

INTERWIKI
    Should be set to a table, with keys corresponding to interwiki
    prefices and the values set to either string prefaces, templates
    or functions. For example:

        INTERWIKI = {
           sputnik = "http://spu.tnik.org/en/",
           wikipedia = "http://en.wikipedia.org/wiki/%s",
           ["lua-users"] = function(node_name)
                              local prefix = "http://lua-users.org/wiki/"
                              return prefix..node_name:gsub("%s", "")
                           end
        }

    So, [[sputnik:Bananas]] will link to
    http://spu.tnik.org/en/Bananas, [[wikipedia:Sputnik
    (software)|Sputnik on Wikipedia]] will link to
    http://en.wikipedia.org/wiki/Sputnik_(software), and
    [[lua-users:Lua Addons]] would link to
    http://lua-users.org/wiki/LuaAddons.

    See http://sputnik.freewisdom.org/en/Interwiki for more examples.
]=]

topics.localization = [[
You can set interface language other than English and set your time
zone.

INTERFACE_LANGUAGE
    Specifies interface language to be used. The default is "en"
    (English).  Other supported languages are "ru" (Russian), "pt"
    (Portuguese) and "es" (Spanish). The translations and the fallback
    rules are defined in sputnik/translations node. You can define new
    translations in that node and then choose them here.

TIME_ZONE
    Time zone in which you want to display times, as an offset from
    GMT.  E.g., if most of your users are in Rio de Janeiro, you can
    set this value to "+0300". The default is "+0000", i.e., GMT.

TIME_ZONE_NAME
    The name for the timezone. E.g., "Rio de Janeiro" or "BRT".
]]

topics.title = [[
You can pick the title and subtitle of your wiki. You can also decide whether
to use a custom font for the title.

SITE_TITLE
    The title shown in the header and included in the HTML <head>
    element.
    
SITE_SUBTITLE
    The sub-title that will be shown in the header.
    
DEFAULT_NAVSECTION
    The section of the navigation bar that would be highlighted if the
    current node does not match any section.

USE_WEB_FONTS
    If Sputnik will use a web font, served from the node
    sputnik/fonts/header.woff, for the site title and subtitle and
    also for the page title. If you want to change the default font,
    you can upload a new woff file into the font node.

]]

topics.user_info = [[
You can use gravatar to identify your users. You can also create a
node representing each user.

USE_GRAVATAR
    Users will be shown with an icon provided by gravatar. (See
    gravatar.com.)  The icon is based on the user's email address, so
    this would only work if the email address is on file.

USE_USER_NODES
    If set to true, a profile node will be created for each user,
    which the user will own.

USER_NODE_PREFIX
    The prefix under which user profile nodes will be created. The
    default is "people/".
    
USER_NODE_PROTOTYPE
    User nodes will inherit from this node. The default is
    "@User_Profile".

]]

topics.http = [[
Parameters that control HTTP transfer.

COOKIE_NAME
    The name for Sputnik's cookie. You will want to change this if you
    are running several instances of Sputnik on the same domain.

USE_COMPRESSION
    If set to true and module zlib is available, then Sputnik will use
    http compression.  ]]

topics.errors = [[
If you can set Sputnik to display stack traces in case of errors.

SHOW_STACK_TRACE
    If set to true, Sputnik will display a stack trace in case of a
    server side error. This is not enabled by default because it is
    somewhat of a security risk.
]]

topics.etc = [[
Here is a list of additional parameters which are not currently
otherwise documented.

DISABLE_XSS_FILTER
HOURS_BEFORE_PASSWORD_TICKET_EXPIRES
INIT_FUNCTION
LUA_VALIDATION_COLOR_INVALID
LUA_VALIDATION_COLOR_UNKNOWN
LUA_VALIDATION_COLOR_VALID
MAX_ITEMS_IN_HISTORY
MIME_TYPES
MORE_CSS
MORE_JAVASCRIPT
NEW_NODE_PROTOTYPES
NUM_HONEYPOTS_IN_FORMS
POST_TOKEN_TIMEOUT
PROTOTYPE_PATTERNS
ROCK_LIST_FOR_VERSION
SEARCH_CONTENT
SEARCH_PAGE
TOOLBAR_COMMANDS
TOOLBAR_ICONS
]]
