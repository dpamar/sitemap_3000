# Cleansing
rm -rf .git/
rm -f page*

# Generate pages
max=$(echo $1 - 1 | bc)
for i in $(seq -w 0 $max); do cat template.html| sed "s/XXX/$i/g;s/YYY/$1/g" > page_$i.html; done

# Generate sitemap
(echo "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">"; for i in page_*; do echo "<url><loc>https://dpamar.github.io/sitemap_$1/$i</loc></url>"; done; echo "</urlset>") > sitemap.xml

# Git push
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/dpamar/sitemap_$1.git
git push -u origin main
