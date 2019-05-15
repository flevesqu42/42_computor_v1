# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flevesqu <flevesqu@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/01/22 00:33:10 by flevesqu          #+#    #+#              #
#    Updated: 2018/08/31 10:44:17 by flevesqu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = computor

RM = rm -f

DEPENDENCIES =	lib/computor/computor.CLI.ex\
				lib/computor/computor.Display.ex\
				lib/computor/computor.Error.ex\
				lib/computor/computor.ex\
				lib/computor/solver/computor.Solver.ex\
				lib/computor/solver/computor.Solver.ZeroDegree.ex\
				lib/computor/solver/computor.Solver.FirstDegree.ex\
				lib/computor/solver/computor.Solver.SecondDegree.ex\
				lib/computor/solver/solution/computor.Solver.Solution.ex\
				lib/computor/solver/solution/computor.Solver.Solution.Classic.ex\
				lib/computor/solver/solution/computor.Solver.Solution.Complex.ex\
				lib/polynom/polynom.ex\
				lib/polynom/polynom.Parser.ex\
				lib/polynom/polynom.String.ex\
				lib/maths/maths.ex

ifdef DEBUG
	WFLAGS += -DDEBUGTTY="$(DEBUG)"
endif

all : $(NAME)

$(NAME) : $(DEPENDENCIES)
	mix escript.build

clean :
	mix clean

fclean : clean
	rm -f $(NAME)

re : fclean all

test : all
	mix test

.PHONY: all clean fclean re
