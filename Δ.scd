this.s_

(
	default

	(
		scsynth

		(
			Server
		)

		.default_

		(
			local

			(
				Server
			)

			.options_

			(
				ServerOptions

				(

				)

				.memSize_

				(
					2 ** 18
				)
			)
		)
	)
)

.y_

(
	(

	)

	.x_

	(
		Array2D

		(
			9 , 9
		)

		with:

		(
			(
				11, 21 ..91
			)

			+.x

			(
				..8
			)
		)
	)
)

.n_

(
	MultiLevelIdentityDictionary

	[

	]

	.putTree

	(
		0 , [ 0 , [ 0
			, y.x[0, 0] , 1
			, y.x[0, 1] , 2
			, y.x[1, 0] , 3
			, y.x[1, 1] ] ] ,
		0 , [ 1 , [ 0
			, y.x[0, 2] , 1
			, y.x[0, 3] , 2
			, y.x[1, 2] , 3
			, y.x[1, 3] ] ] ,
		0 , [ 2 , [ 0
			, y.x[2, 0] , 1
			, y.x[2, 1] , 2
			, y.x[3, 0] , 3
			, y.x[3, 1] ] ] ,
		0 , [ 3 , [ 0
			, y.x[2, 2] , 1
			, y.x[2, 3] , 2
			, y.x[3, 2] , 3
			, y.x[3, 3] ] ] ,
		1 , [ 0 , [ 0
			, y.x[0, 4] , 1
			, y.x[0, 5] , 2
			, y.x[1, 4] , 3
			, y.x[1, 5] ] ] ,
		1 , [ 1 , [ 0
			, y.x[0, 6] , 1
			, y.x[0, 7] , 2
			, y.x[1, 6] , 3
			, y.x[1, 7] ] ] ,
		1 , [ 2 , [ 0
			, y.x[2, 4] , 1
			, y.x[2, 5] , 2
			, y.x[3, 4] , 3
			, y.x[3, 5] ] ] ,
		1 , [ 3 , [ 0
			, y.x[2, 6] , 1
			, y.x[2, 7] , 2
			, y.x[3, 6] , 3
			, y.x[3, 7] ] ] ,
		2 , [ 0 , [ 0
			, y.x[4, 0] , 1
			, y.x[4, 1] , 2
			, y.x[5, 0] , 3
			, y.x[5, 1] ] ] ,
		2 , [ 1 , [ 0
			, y.x[4, 2] , 1
			, y.x[4, 3] , 2
			, y.x[5, 2] , 3
			, y.x[5, 3] ] ] ,
		2 , [ 2 , [ 0
			, y.x[6, 0] , 1
			, y.x[6, 1] , 2
			, y.x[7, 0] , 3
			, y.x[7, 1] ] ] ,
		2 , [ 3 , [ 0
			, y.x[6, 2] , 1
			, y.x[6, 3] , 2
			, y.x[7, 2] , 3
			, y.x[7, 3] ] ] ,
		3 , [ 0 , [ 0
			, y.x[4, 4] , 1
			, y.x[4, 5] , 2
			, y.x[5, 4] , 3
			, y.x[5, 5] ] ] ,
		3 , [ 1 , [ 0
			, y.x[4, 6] , 1
			, y.x[4, 7] , 2
			, y.x[5, 6] , 3
			, y.x[5, 7] ] ] ,
		3 , [ 2 , [ 0
			, y.x[6, 4] , 1
			, y.x[6, 5] , 2
			, y.x[7, 4] , 3
			, y.x[7, 5] ] ] ,
		3 , [ 3 , [ 0
			, y.x[6, 6] , 1
			, y.x[6, 7] , 2
			, y.x[7, 6] , 3
			, y.x[7, 7] ] ]

	)

	.addUniqueMethod

	(
		\matrix,							//	n.matrix

		{
			fill3D

			(
				Array,	4, 4, 4,

				{
					|...x| 	x -> atPath ( n , x )
				}
			)

			flatten:

			(
				3
			)
		}
	)

	.addUniqueMethod

	(
		\index,								//	n.index	( # , # , # )

		{
			|...x|

			n.matrix detectIndex:

			(
				_.key |==| x[1..3]
			)
		}
	)

	.addUniqueMethod

	(
		\key,								//	n key: #

		{
			|...v|

			key

			(
				n.matrix detect:

				(
					_.value |==| v[1]
				)
			)
		}
	)
)

. s	. doWhenBooted

{
	\//

	. addUniqueMethod

	(
		\//

		,

		compile

		(
			thisProcess.nowExecutingPath.quote
		)
	)

	. addUniqueMethod

	(
		\x

		,

		{
			|...x|	\.envirPut( x[1] ? \.envirGet )
		}
	)

	;

	~source =

	(
		(

		)

		.index_

		{
			MIDIClient.sources.indexOf

			(
				MIDIClient.sources.last
			)
		}

		.in_

		{
			MIDIClient.sources

			[
				~source.index
			]
		}

		.x_

		(
			(

			)

			.index_

			{
				MIDIClient.destinations.indexOf

				(
					MIDIClient.destinations.last
				)
			}

			.in_

			{
				MIDIClient.destinations

				[
					~source.x.index
				]
			}
		)
	)

	;

	MIDIClient.init

	(
		verbose: false
	)

	;

	{
		connect

		(
			disconnect

			(
				MIDIIn , *

				[
					~source.index,

					~source.in.uid
				]
			)

			, *

			[
				~source.index,

				~source.in.uid
			]
		)
	}

	try:

	{
		connectAll

		(
			MIDIIn
		)
	}

	;

	~source.x_

	(
		MIDIOut

		(
			~source.x.index,		//	~source.x.port

			~source.x.in.uid		//	~source.x.uid
		)
	)

	;

	$ . addUniqueMethod

	(
		\sys_x ,

		{
			|...x|

			~source . x . sysex

			(
				Int8Array . with

				(
					0xf0 , 0x , 0x20 , 0x29 , 0x2 , 0xd , * x[1..] ++ 0xf7
				)

			)

			!?

			{
				$ //
			}

		}

	)

	. addUniqueMethod

	(
		\x ,

		{
			|...x|

			$ . sys_x

			(
				3 , 3 , at

				(
					n , x@1 , x@2 , x@3
				)

				, x@4 ? index

				(
					n , x@1 , x@2 , x@3
				)

				. linexp

				(
					0 , 63 , 3 , 127
				)

				, x@5 ?

				(
					g ? 0
				)

				, x@6 ?

				(
					b ? 0
				)

			)

		}

	)

	. addUniqueMethod

	(
		\v ,

		{
			|...v|

			sys_x

			(
				sys_x

				(
					sys_x

					(
						$ , *

						[
							14 , 1
						]
					)

					, *

					[
						9 , 1
					]
				)

				, *

				[
					8 ,

					(	127 /

						(	round

							(	dbamp

								(	max

									(	volume

										(
											s
					)	)	)	)	)	)

					*

					(	dbamp

						(	volume

							(	volume

								(	s.volume_

									(	ampdb

										(	v[1] /

											(	127 /

												(	round

													(	dbamp

														(	max

															(	volume

																(
																	s
					)	)	)	)	)	)	)	)	)	)	)	)

				]

			)

		}

	)

	;

	MIDIdef

	(
		$.

		,

		{
			|vl|

			vl . sign . switch

			{
				1
			}

			{
				run

				(
					CmdPeriod
				)
			}
		}

		,

		msgNum:

		(
			last

			(
				y.x rowAt: 0
			)
		)

		,

		msgType:

		(
			\control
		)

	)

	.permanent_

	(
		true
	)

	;

	CmdPeriod


	.clearClocks_

	(
		false
	)

	.freeServers_

	(
		false
	)

	.freeRemote_

	(
		false
	)

	.removeAll

	//	.objects_

	.add

	{
		SystemClock.clear.sched

		(
			3/8,

			{
				128.reverseDo

				{
					|n|

					{
						~source.x.noteOff

						(
							0 , n
						)
					}

					defer:

					(
						1/8 * 128/n
					)
				}
			}
		)
	}

	.doOnce

	(
		{
			\ . n

			(
				27, 30, 33, 36, 40.5, 45, 48, 51
			)
		}

		<>

		{
			$ . v

			(
				121
			)
		}

		<>

		{
			\ . n

			(
				* 3  !  3 . squared
			)
		}
	)

	.add

	(
		{
			MIDIIn.noteOn_

			{
				|src lvl n|

				x .

				(
					n
				)
			}
		}

		<>

		{
			[
				UniqueID , ObjectTable
			]

			reverseDo:

			(
				initClass

				(
					_
				)
			)
		}

		<>

		{
			x_

			(
				this ,

				{
					|x|

					x =

					(
						UniqueID.cprototype[0] +.x 1..

						(
							ObjectTable add: key

							(
								n , x
							)
						)
					)

					collect:

					(
						ObjectTable at: _
					)

					;

					SystemClock.clear.sched

					(
						0 , cyc

						(
							1
						)

						<> r

						{
							$ . x ( * x . foldAt ( x . size ) ++ ( 0 ! 3 ) )


							. x ( * x . wrapAt ( x . size ) ++ ( 0 ! 3 ) ) .


							x ( * x . clipAt ( x . size ) )


							;


							inf . yield


							;


							$ . x ( * x . last ++ ( 0 ! 3 )  )


							;


							inf . yield


							;


							x [ x . size - 3 ] !?

							{
								$ . x ( * x [ x . size - 3 ] )
							}


							;


							inf . yield


							;


							x [ x . size - 3 ] !?

							{
								$ . x ( * x [ x . size - 3 ] ++ ( 0 ! 3 ) )
							}


							;


							x [ x . size - 2 ] !?

							{
								$ . x ( * x [ x . size - 2 ] )
							}


							;


							inf . yieldAndReset

						}

					)

					;

					(
						(
							x
						)

						.size
					)

					.switch

					{
						1	}
					{
						\.x

						(
							mkdir

							(
								format

								(
									"%/%"

									,

									first

									(
										splitext

										(
											\ applyTo: \
										)
									)

									,

									first

									(
										x
									)
								)
							)
						)
					}

					{
						2	}
					{
						\.x

						(
							mkdir

							(
								format

								(
									"%/%"

									,

									\.x

									,

									x[1]
								)
							)
						)
					}

					{
						3	}
					{
						if

						(
							File exists:

							(
								\.x

								(
									format

									(
										"%/%.%"

										,

										\.x

										,

										last

										(
											x
										)

										,

										last

										(
											splitext

											(
												\ applyTo: \
											)
										)
									)
								)
							)

							,

							{
								load

								(
									\.x
								)
							}

							<>

							{
								x_

								(
									this , { }
								)
							}

							<>

							{
								run

								(
									CmdPeriod
								)
							}

							,

							{
								open

								(
									Document , \.x
								)
							}

							<>

							{
								writeArchive

								(
									this.x , \.x
								)
							}

							<>

							{
								x_

								(
									this , { }
								)

							}

						)

					}

				}

			)

		}

	)

	. run

}

. boot

;

\//

. addUniqueMethod

(
	\n ,

	{
		|...n|

		remove

		(
			n , \//
		)

		;

		n . size . switch

		{

			8	 }

		{
			~n =

			(
				geom

				(
					8 , 1 , round ( n . last / n . first )
				)

				*.x

				(
					n
				)
			)
		}

		{

			3	 }

		{
			var	root, tuning, scale;	# root, tuning, scale = n;

			~n =

			(
				geom

				(
					8 , 1 , octaveRatio ( tuning . asTuning )
				)

				*.x

				(
					root * ratios ( perform ( Scale , scale , tuning ) )
				)
			)
		}

		{

			1	 }

		{
			~n

			[
				this . n . index

				(
					*

					this . n . key

					(
						*

						n
					)
				)
			]
		}

		{

			0	 }

		{
			Tuning . names . collect

			{
				|tuning| tuning ->


				Scale . names . select

				{
					|scale|	tuning . asTuning . size


					|==| Scale . at ( scale ) . pitchesPerOctave
				}

				. as ( OrderedIdentitySet ) . add ( \chromatic )
			}

			. reverseDo

			{
				|x| Post <<< x . key << $\n <<* x . value << $\n << $\n
			}
		}

		{

			9	 }

		{
			load

			(
				splitext

				(
					\ applyTo: \
				)

				.insert

				(
					1 ,	format

					(
						"/%/%/%." , * reshape

						(
							n , 3 , 3
						)

					)

				)

				.join

			)

		}

	}

)