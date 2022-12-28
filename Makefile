today = $(shell date "+%Y%m%d")
product_name = vupueue

.PHONY : patch
patch : diff-patch

.PHONY : format-patch
format-patch :
	git format-patch origin/master

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(product_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : install
install :
	sudo cp ./$(product_name) ~/.local/bin/$(product_name)

.PHONY : clean
clean : clean-zip
	rm -f fmt-*
	rm -f *.patch

.PHONY : lint
lint :
	shellcheck ./$(product_name)

.PHONY : test
test : lint

.PHONY : format
format :
	shfmt ./$(product_name) > fmt-$(product_name)
	mv ./fmt-$(product_name) ./$(product_name)
	chmod +x ./$(product_name)

.PHONY : fmt
fmt : format

.PHONY : zip
zip :
	zip -r $(product_name).zip ./* ./.gitignore

.PHONY : clean-zip
clean-zip :
	rm -f *.zip

.PHONY : zip-copy2win
zip-copy2win : $(product_name).zip
	cp *.zip $$WIN_HOME/Downloads/

