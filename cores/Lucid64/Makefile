
.PHONY: test results clean

GEN_CHECKS_SCRIPT=../../checks/genchecks.py
CONFIG_NAME=Lucid64_formal
LIST_TESTS := $(shell find $(CONFIG_NAME) -mindepth 1 -maxdepth 1 -type d | sed 's|$(CONFIG_NAME)/||')

test:
	python3 $(GEN_CHECKS_SCRIPT) $(CONFIG_NAME)
	$(MAKE) -i -C $(CONFIG_NAME)
	$(MAKE) results


results:
	@echo "Checking test results:"
	@for d in $(LIST_TESTS); do \
	  if [ -f $(CONFIG_NAME)/$$d/PASS ]; then \
	    printf "%-30s %b\n" $$d "\033[1;32mPASS\033[0m"; \
	  elif [ -f $(CONFIG_NAME)/$$d/FAIL ]; then \
	    printf "%-30s %b\n" $$d "\033[1;31mFAIL\033[0m"; \
	  elif [ -f $(CONFIG_NAME)/$$d/ERROR ]; then \
	    printf "%-30s %b\n" $$d "\033[1;30mERROR\033[0m"; \
	  else \
	    printf "%-30s %b\n" $$d "\033[1;36mUNKNOWN\033[0m"; \
	  fi; \
	done


clean:
	rm -rf $(CONFIG_NAME)
