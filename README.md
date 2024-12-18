This is a lean Docker image for WebSVN 2.8.4 (https://websvnphp.github.io/). The Docker image was forked from https://github.com/pschatzmann/docker-websvn and updated from `php:5.6-alpine` to `php:8.4-cli-alpine`.
It uses the embedded PHP web server, which is only recommended for dev environments and *not* for heavy production use (in that case you would want a properly configured HTTP server such as Apache).

At run time you can provide the SVN repo via the `repository` environment variable, that is used in the sample *config.php* which is copied into `/var/www/html/websvn/include/` during Docker build time. Check the WebSVN docs for details about the config file and modify it to suit your requirements before building the Docker image.
The SVN repo URL can be in any format supported by Subversion and depending on your config, such as "file://..." for a locally mounted repo (would need to be mapped as a Docker volume), "svn://...", etc.

Build example: `sudo docker build . -t websvn:2.8.4`

Run example: `sudo docker run -d -e repository=svn://10.0.1.2/myrepo -p 8080:80 --name websvn websvn:2.8.4`
This would map port 80 of the container to port 8080 of the host (which runs Docker), where it's normally easier / recommended to use port numbers above 1024.