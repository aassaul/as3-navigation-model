/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 21:54
 */
package com.trembit.navigation.events {
import com.trembit.navigation.model.vo.StateVO;

import flash.events.Event;

public final class NavigationModelEvent extends Event {

	public static const CURRENT_STATE_CHANGE:String = "currentStateChange";

	private var _previousState:StateVO;
	private var _newState:StateVO;

	public function get previousState():StateVO {
		return _previousState;
	}

	public function get newState():StateVO {
		return _newState;
	}

	public function NavigationModelEvent(eventType:String, previousState:StateVO, newState:StateVO) {
		super(eventType, false, false);
		_newState = newState;
		_previousState = previousState;
	}

	override public function clone():Event {
		return new NavigationModelEvent(type, previousState, newState);
	}
}
}
