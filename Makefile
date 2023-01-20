today = $(shell date "+%Y%m%d")
product_name = vupueue

.PHONY : patch
patch : clean diff-patch copy2win

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(product_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : copy2win
copy2win :
	cp *.patch $$WIN_HOME/Downloads/

.PHONY : install
install :
	sudo cp ./$(product_name).sh ~/.local/bin/$(product_name)

.PHONY : clean
clean :
	rm -f fmt-*
	rm -f *.patch

.PHONY : lint
lint :
	shellcheck ./$(product_name).sh

.PHONY : test
test : lint

.PHONY : format
format :
	shfmt ./$(product_name).sh > ./fmt-$(product_name).sh
	mv ./fmt-$(product_name).sh ./$(product_name).sh
	chmod +x ./$(product_name).sh

.PHONY : fmt
fmt : format
