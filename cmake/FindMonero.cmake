#------------------------------------------------------------------------------
# CMake helper for the majority of the cpp-ethereum modules.
#
# This module defines
#     Monero_XXX_LIBRARIES, the libraries needed to use ethereum.
#     Monero_FOUND, If false, do not try to use ethereum.
#
# File addetped from cpp-ethereum
#
# The documentation for cpp-ethereum is hosted at http://cpp-ethereum.org
#
# ------------------------------------------------------------------------------
# This file is part of cpp-ethereum.
#
# cpp-ethereum is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cpp-ethereum is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cpp-ethereum.  If not, see <http://www.gnu.org/licenses/>
#
# (c) 2014-2016 cpp-ethereum contributors.
#------------------------------------------------------------------------------

set(LIBS common;blocks;cryptonote_basic;cryptonote_core;
		cryptonote_protocol;daemonizer;mnemonics;epee;lmdb;
		blockchain_db;ringct;wallet)

set(Xmr_INCLUDE_DIRS "${CPP_MONERO_DIR}")


foreach (l ${LIBS})

	string(TOUPPER ${l} L)

	find_library(Xmr_${L}_LIBRARY
		NAMES ${l}
		PATHS ${CMAKE_LIBRARY_PATH}
		PATH_SUFFIXES "/src/${l}" "/external/db_drivers/lib${l}" "/lib" "/src/crypto" "/contrib/epee/src"
		NO_DEFAULT_PATH
	)

	set(Xmr_${L}_LIBRARIES ${Xmr_${L}_LIBRARY})

	message(STATUS FindMonero " Xmr_${L}_LIBRARIES ${Xmr_${L}_LIBRARY}")

	add_library(${l} STATIC IMPORTED)
	set_property(TARGET ${l} PROPERTY IMPORTED_LOCATION ${Xmr_${L}_LIBRARIES})

endforeach()


if (EXISTS ${MONERO_BUILD_DIR}/external/unbound/libunbound.a)
	add_library(unbound STATIC IMPORTED)
	set_property(TARGET unbound PROPERTY IMPORTED_LOCATION ${MONERO_BUILD_DIR}/external/unbound/libunbound.a)
endif()

if (EXISTS ${MONERO_BUILD_DIR}/src/crypto/libcrypto.a)
	add_library(cryptoxmr STATIC IMPORTED)
	set_property(TARGET cryptoxmr
			PROPERTY IMPORTED_LOCATION ${MONERO_BUILD_DIR}/src/crypto/libcrypto.a)
endif()